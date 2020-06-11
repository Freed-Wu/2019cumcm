function [a y_new err]=Le_Sq(x,y,n)
n_x=length(x);
n_y=length(y);
if n_x==n_y
    %����xά�Ƚ�����ֵ��һ����������Ϊ��ֵ�ݴ��ۼӹ����µľ���������
    %yά������ֻ�Ǽ򵥵���ˣ�����Ҫ���棬�ʲ�����
    max_x=max(abs(x));
    max_x_0=max(x);
    min_x_0=min(x);
    if max_x_0==min_x_0
        a=0
        y_new=zeros(n_y,0);
        err=0;
        warning('����ά��Ϊ�Ǻ�����һֵ��ֵ��')
    else
        x=x./max_x*5;%*5��Ϊ��������֤ʮ�����£�����5^10=9765625���ݹ�ģ��Ȼ�ɿأ��Ҷ��ڸ��㾫�Ƚ����˱�֤
        Flp=zeros(n+1,n+1);
        Flq=zeros(n+1,1);
        for ii=1:n+1
            for jj=1:n+1
                for kk=1:n_x
                    Flp(ii,jj)=Flp(ii,jj)+power(x(kk),(ii+jj-2));
                end
            end
            for kk=1:n_x
                Flq(ii)=Flq(ii)+power(x(kk),(ii-1))*y(kk);
            end
        end
        a=inv(Flp)*Flq;
        y_new=zeros(1,n_x);
        %��������
        x=x.*max_x/5;
        for ii=1:n+1
            a(ii)=a(ii)*power(5/max_x,(ii-1));
        end
        for ii=1:n_x
            for jj=1:n+1
                y_new(ii)=y_new(ii)+a(jj)*power(x(ii),(jj-1));
            end
        end
        err=sum(abs(y_new-y'));
    end
else
     warning('����ά�������ά�Ȳ���')
end
end

