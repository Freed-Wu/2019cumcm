%宏观寻找
X=zeros(200,20);
Y=zeros(200,20);
for ii=1:200
    parfor jj=1:20
        dt=0.2+ii*0.001;
        tic
        [PP T]=Prob_12(100,dt,0.04,10000,(jj-1)*5);
        toc
        err(ii,jj)=sum(abs(PP-100));
        X(ii,jj)=dt;
        Y(ii,jj)=(jj-1)*5;
    end
end
mesh(X,Y,err)
min_er=min(min(err));
[m n]=find(err==min_er);
ddt=(X(m+1,n)-X(m-1,n))/10;
dds=(Y(m,n+1)-Y(m,n-1))/10;
%伪二分法细化（分十份）
X_2=zeros(11,11);
Y_2=zeros(11,11);
err_2=zeros(11,11);
for kk=1:1
    tic
    for ii=1:11
        parfor jj=1:11    
            dt=X(m-1,n)+ii*ddt;
            ds=Y(m,n-1)+jj*dds;
            [PP T]=Prob_12(100,dt,0.04,5000,ds);
            err_2(ii,jj)=sum(abs(PP-100));
            X_2(ii,jj)=dt;
            Y_2(ii,jj)=ds;
        end
    end
    toc
end
for kk=1:10
    tic
    min_er=min(min(err_2));
    [m n]=find(err_2==min_er);
    ddt=(X_2(m+1,n)-X_2(m-1,n))/10;
    dds=(Y_2(m,n+1)-Y_2(m,n-1))/10;
    for ii=1:11
        for jj=1:11   
            dt=X_2(m-1,n)+ii*ddt;
            ds=Y_2(m,n-1)+jj*dds;
            [PP T]=Prob_12(100,dt,0.04,5000,ds);
            err_2(ii,jj)=sum(abs(PP-100));
            X_2(ii,jj)=dt;
            Y_2(ii,jj)=ds;
        end
    end
    toc
    kk
end
min_er=min(min(err_2));    
[m n]=find(err_2==min_er);
X_2(m,n)
Y_2(m,n)
[PP T]=Prob_12(100,X_2(m,n),0.04,500000,Y_2(m,n));