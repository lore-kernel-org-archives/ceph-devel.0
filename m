From: John Axel Eriksson <john@insane.se>
Subject: Re: AW: RadosGW S3 Api
Date: Fri, 1 Feb 2013 14:25:36 -0800
Message-ID: <AB0C5C24-965E-4916-9D18-FD738116C7FA@insane.se>
References: <5EFBD28BA42C604BB012164C72CA5604502B0E1D@SMBXKO6.cgm.ag> <5EFBD28BA42C604BB012164C72CA5604502B0E6B@SMBXKO6.cgm.ag> <CAC-hyiGdR8AMMFk41tWgjmYNAqffTd8R8UacdcaFEPErEr=+Rw@mail.gmail.com> <5EFBD28BA42C604BB012164C72CA5604502B0EDE@SMBXKO6.cgm.ag> <CAC-hyiEFYF4xGx3nAWaOBDjrRTxLJ_P33A40NescWLBeCnATyQ@mail.gmail.com> <5EFBD28BA42C604BB012164C72CA5604502B0F34@SMBXKO6.cgm.ag> <CAMmJxtJrsC0C+6JiCKntytgmwANfDf8e2fpKQkOwF=KV+=kCEQ@mail.gmail.com> <5EFBD28BA42C604BB012164C72CA5604502B23ED@SMBXKO6.cgm.ag>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57826 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757724Ab3BAWZj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 17:25:39 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so1527163pad.24
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 14:25:39 -0800 (PST)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA5604502B23ED@SMBXKO6.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "=?utf-8?Q? J=C3=A4ger,_Philipp ?=" <Philipp.Jaeger@cgm.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Unfortunately we're not using it that
way, so I don't know what possibilities there are. Hopefully someone el=
se can help you out.

Good luck!

31 jan 2013 kl. 10:32 skrev J=C3=A4ger, Philipp <Philipp.Jaeger@cgm.com=
>:

> Hello,
>=20
> thank you very very much, it works in general now =E2=98=BA
>=20
> Can you say something about how to limit the rights of the user I cre=
ated like in the manual?
> We want to create an account, which has no rights to create buckets. =
cannot find a fitting manual for that.
>=20
> Thank you very much
>=20
> Regards
> Philipp
>=20
> Von: John Axel Eriksson [mailto:john@insane.se]=20
> Gesendet: Donnerstag, 31. Januar 2013 00:11
> An: J=C3=A4ger, Philipp
> Cc: Yehuda Sadeh; ceph-devel@vger.kernel.org
> Betreff: Re: RadosGW S3 Api
>=20
> This is the config we're using:
>=20
> FastCgiExternalServer /tmp/radosgw.fcgi -socket /var/run/ceph/rgw.soc=
k
>=20
> LogFormat "%{X-Forwarded-For}i %l %u %t \"%r\" %>s %O \"%{Referer}i\"=
 \"%{User-Agent}i\"" proxy_combined
> LogFormat "%{X-Forwarded-For}i %h %l %u %t \"%r\" %>s %O \"%{Referer}=
i\" \"%{User-Agent}i\"" proxy_debug
>=20
> <VirtualHost *:443>
>   ServerName <ourservername>
>   ServerAlias *
>   ServerAdmin admin@<ourservername>
>   DocumentRoot /var/www
>=20
>   KeepAlive off
>=20
>   SSLEngine on
>   SSLCertificateFile /etc/apache2/ssl.cert
>   SSLCertificateKeyFile /etc/apache2/ssl.key
>   SetEnvIf User-Agent ".*MSIE.*" nokeepalive ssl-unclean-shutdown
>=20
>   RewriteEngine On
>   RewriteRule             ^/(.*) /radosgw.fcgi?%{QUERY_STRING} [E=3DH=
TTP_AUTHORIZATION:%{HTTP:Authorization},L]
>=20
>   <IfModule mod_fastcgi.c>
>     <Directory /var/www/>
>       Options +ExecCGI
>       AllowOverride All
>       SetHandler fastcgi-script
>       Order allow,deny
>       Allow from all
>       AuthBasicAuthoritative Off
>     </Directory>
>   </IfModule>
>=20
>   AllowEncodedSlashes On
>=20
>   ErrorLog /var/log/apache2/error.log
>   CustomLog /var/log/apache2/rgw-access.log proxy_combined
>   ServerSignature Off
> </VirtualHost>
>=20
> Hope it helps!
>=20
> John
>=20
> On Wed, Jan 30, 2013 at 10:13 AM, J=C3=A4ger, Philipp <Philipp.Jaeger=
@cgm.com> wrote:
> Yeah, therefore i ask about an example apache config with ssl support=
, its not described in the ceph manual, only you have to active the ssl=
 module, but not how the conf must look.
> I tested the freeware "s3 browser", but it makes also errors...
>=20
> Do you somebody know who has knowledge about using radosgw with ssl?
>=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: yehudasa@gmail.com [mailto:yehudasa@gmail.com] Im Auftrag von Ye=
huda Sadeh
> Gesendet: Mittwoch, 30. Januar 2013 18:54
> An: J=C3=A4ger, Philipp
> Cc: ceph-devel@vger.kernel.org
> Betreff: Re: RadosGW S3 Api
>=20
> On Wed, Jan 30, 2013 at 9:34 AM, J=C3=A4ger, Philipp <Philipp.Jaeger@=
cgm.com> wrote:
>> Hello, thanks for the answer.
>> I don't know, the programmer say the api (s3 api java) wants to conn=
ect per https. When you know a possibility to  (de)actiate ssl, I would=
 be happy you can tell:) than im sure its not a ssl problem.
>>=20
>>=20
>> Do you know the error message "peer not authenticated"?
>> I think its not a rados error message, because when you google for i=
t, you can see that it's common ssl error in java.
>=20
> Then it's probably ssl error. Radosgw doesn't generate such an error.
>=20
>> But it can be an inherited error because of rados misconfiguration I=
 think.
>>=20
>>=20
>> How do I know if the gateway can be reached?
>> Nothing special in the logs..
>>=20
>> Have you looked into the confs in the zip file I added to the mail?
>=20
> Yeah. there's not much there.
>=20
>> Im very unsure about the apache ssl configuration, when I set the fa=
stcgi virtual host section also to 443, I get an error message, but I d=
onk think its right to leave it on 80.
>=20
>=20
>> Don't you ever set up radosgw with ssl ?
>=20
> that's really orthogonal to radosgw, more of the web server (apache) =
issue.
>=20
> Try using some out of the box s3 client before using the api to help =
with diagnosing the issue. It looks to me like some issues with your ap=
ache configuration (ssl, fastcgi).
>=20
>=20
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
