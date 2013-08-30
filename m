From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: [ceph-users] ceph s3 allowed characters
Date: Fri, 30 Aug 2013 16:44:36 +0200
Message-ID: <CAMNMNTyUucZ2ZZu_KwfX2mz77Zx45Lf1j9xRYRNDJWdgF1LkPw@mail.gmail.com>
References: <CAMNMNTxn3DCbVAnvY1K7PE7Z1oWy-4nM_XKT92+xYEBxKzd=Yg@mail.gmail.com>
	<CANtztVysF7AbZiMimU1zhyBPu35+xQhSvUU+PNRDb42ro2uhng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37259 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab3H3Ooh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Aug 2013 10:44:37 -0400
Received: by mail-qa0-f53.google.com with SMTP id i13so1196564qae.19
        for <ceph-devel@vger.kernel.org>; Fri, 30 Aug 2013 07:44:36 -0700 (PDT)
In-Reply-To: <CANtztVysF7AbZiMimU1zhyBPu35+xQhSvUU+PNRDb42ro2uhng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <alfredo.deza@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

(echo -n 'GET /dysk/files/test.test%40op.pl/DOMIWENT%202013/Damian%20DW=
/dw/Specyfikacja%20istotnych%20warunk%F3w%20zam%F3wienia.doc
HTTP/1.0'; printf "\r\n\r\n") | nc localhost 88
HTTP/1.1 400 Bad Request
Date: Fri, 30 Aug 2013 14:10:07 GMT
Server: Apache/2.2.22 (Ubuntu)
Accept-Ranges: bytes
Content-Length: 83
Connection: close
Content-Type: application/xml

<?xml version=3D"1.0"
encoding=3D"UTF-8"?><Error><Code>InvalidObjectName</Code></Error>

=46ull log from radosgw another error:

2013-08-30 14:32:52.166321 7f42e77d6700  1 =3D=3D=3D=3D=3D=3D starting =
new request
req=3D0x12cff20 =3D=3D=3D=3D=3D
2013-08-30 14:32:52.166385 7f42e77d6700  2 req 33246:0.000065::::initia=
lizing
2013-08-30 14:32:52.166410 7f42e77d6700 10 meta>> HTTP_X_AMZ_ACL=3Dpubl=
ic-read
2013-08-30 14:32:52.166419 7f42e77d6700 10 x>> x-amz-acl:public-read
2013-08-30 14:32:52.166497 7f42e77d6700 10
s->object=3Dfiles/test.test@op.pl/DOMIWENT 2013/DW 2013_03_27/PROJEKTY
2012/ZB KROL/Szko=B3a =A3aziska ZB
KROL/sala-<A3>aziska_Dolne_PB-0_went_15_11_06 Layou
t1 (4).pdf s->bucket=3Ddysk
2013-08-30 14:32:52.166563 7f42e77d6700  2 req 33246:0.000242::POST
/dysk/files/test.test%40op.pl/DOMIWENT%202013/DW%202013_03_27/PROJEKTY%=
202012/ZB%20KROL/Szko%C5%82a%20%C5%81aziska%20ZB%20KROL
/sala-%A3aziska_Dolne_PB-0_went_15_11_06%20Layout1%20%284%29.pdf::http
status=3D400
2013-08-30 14:32:52.166653 7f42e77d6700  1 =3D=3D=3D=3D=3D=3D req done
req=3D0x12cff20 http_status=3D400 =3D=3D=3D=3D=3D=3D

--
Dominik

2013/8/30 Alfredo Deza <alfredo.deza@inktank.com>:
>
>
>
> On Fri, Aug 30, 2013 at 9:52 AM, Dominik Mostowiec
> <dominikmostowiec@gmail.com> wrote:
>>
>> Hi,
>> I got err (400) from radosgw on request:
>> 2013-08-30 08:09:19.396812 7f3b307c0700  2 req 3070:0.000150::POST
>>
>> /dysk/files/test.test%40op.pl/DOMIWENT%202013/DW%202013_03_27/PROJEK=
TY%202012/ZB%20KROL/Szko%C5%82a%20%C5%81aziska%20ZB%20KROL/sala-%A3azis=
ka_Dolne_PB-0_went_15_11_06%20Layout1%20%283%29.pdf::http
>> status=3D400
>> 2013-08-30 08:09:34.851892 7f3b55ffb700 10
>> s->object=3Dfiles/test.test@op.pl/DOMIWENT 2013/Damian
>> DW/dw/Specyfikacja istotnych warunk<F3>w zam<F3>wienia.doc
>> s->bucket=3Ddysk
>>
>> What is allowed range of chars in url in radosgw?
>
>
> Can you post the full HTTP headers for the response?
>
> The output you are pasting is not entirely clear to me, is that a sin=
gle log
> line for the whole request? Maybe it is just the formatting that
> is throwing me off.
>>
>>
>> --
>> Regards
>> Dominik
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>



--=20
Pozdrawiam
Dominik
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
