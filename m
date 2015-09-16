From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw: the swift key remains after removing a subuser
Date: Wed, 16 Sep 2015 08:16:19 -0700
Message-ID: <CADRKj5SWgAiAXuQPWkUF+Fc86kbn6rUOPg32LjQDz+eGFb9ETg@mail.gmail.com>
References: <FF8D83DAE5DF57468726B79904321E06043079@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33494 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbbIPPQU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Sep 2015 11:16:20 -0400
Received: by obbbh8 with SMTP id bh8so151548423obb.0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Sep 2015 08:16:19 -0700 (PDT)
In-Reply-To: <FF8D83DAE5DF57468726B79904321E06043079@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: "xusangdi@126.com" <xusangdi@126.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 15, 2015 at 11:49 PM, Xusangdi <xu.sangdi@h3c.com> wrote:
> I resend this email because I found that somehow the one from ceph-de=
vel could not be opened normally. Just wanna make sure you received it,=
 thank you.
>
>
> Hi Yehuda,
>
> I believe you noticed this issue (http://tracker.ceph.com/issues/1289=
0) as you changed the priority to high. I need your help about the foll=
owing related questions:
> 1. When removing a subuser, is it okay to set '--purge-keys' as the d=
efault option?
> If we do so, there is no way to keep the keys since we don't have opt=
ions like --keep-keys. IMO that is acceptable, but I'm not sure if ther=
e exist some scenarios that users want to just delete a subuser but pre=
serve its keys.

Yeah, I think it's fine removing its keys if it doesn't exist anymore.

>
> 2. Do we need to purge both S3 keys and swift keys at the same time?
> Though ceph documents claim that subuser is designed for swift API, i=
t is allowed to create s3 access-secret key pairs for subusers, and the=
y can be used through s3 interface without any problem. Moreover, when =
creating a subuser with the command 'radosgw-admin subuser create --uid=
=3Dtest --subuser=3Dtest:sub', ceph would by default create an s3 key p=
air for the subuser. Thus, if we do want to purge keys, I think it is n=
ecessary to check both s3 and swift keys and delete all associate entri=
es.

Yes, both S3 and swift keys for that specific subuser.

>
> 3. Do we need to prevent a subuser without any permission from obtain=
ing the account information?
> Currently a subuser with permission <none> can get some of the accoun=
t metadata and its bucket list. The following shows a part of my testin=
g result:
>         sandy@ceph20:~$ curl -i $url -X GET -H "X-Auth-Token: $token"
>         HTTP/1.1 200 OK
>         X-Timestamp: 1442367990.90740
>         X-Account-Container-Count: 1
>         X-Account-Object-Count: 2
>         X-Account-Bytes-Used: 41943040
>         X-Account-Bytes-Used-Actual: 41943040
>         X-Trans-Id: ts-default.64171.86-20150916:014630:904
>         Content-type: text/plain; charset=3Dutf-8
>         Content-Length: 9
>         Date: Wed, 16 Sep 2015 01:46:30 GMT
>
>         bkt_test
>

I'm not sure. The permissions are either read, write, or delete, which
don't make sense with regard to this operation. I think we would need
to add a new permission type for it to make sense, but I'm not sure
this is something we need or want to pursue.

>
> When doing the tests, I also encountered several other issues that I =
cannot tell whether are bugs or designed on purpose.
> i1: As mentioned in question 2, a subuser is created with s3 keys rat=
her than a swift key.

This is probably a bug. I vaguely remember merging in or reviewing a
related fix recently. Are you running the latest?

> i2: The auto-generated s3 secret key is empty, and it is regarded as =
valid.

Sounds like a bug.

> i3: The account metadata obtained from swift API contains doubled obj=
ect count and bytes used. For a subuser possessing one container and on=
e object, the results may look like this:
>         sandy@ceph20:~$ curl -i $url -X GET -H "X-Auth-Token: $token2=
"
>         HTTP/1.1 200 OK
>         X-Timestamp: 1442371316.79489
>         X-Account-Container-Count: 1
>         X-Account-Object-Count: 2
>         X-Account-Bytes-Used: 41943040
>         X-Account-Bytes-Used-Actual: 41943040
>         X-Trans-Id: ts-default.64171.99-20150916:024156:790
>         Content-type: text/plain; charset=3Dutf-8
>         Content-Length: 9
>         Date: Wed, 16 Sep 2015 02:41:56 GMT
>
>         bkt_test
>
>         sandy@ceph20:~$ curl -i $url/bkt_test -X GET -H "X-Auth-Token=
: $token2"
>         HTTP/1.1 200 OK
>         X-Timestamp: 1442280690.00000
>         X-Container-Object-Count: 1
>         X-Container-Bytes-Used: 20971520
>         X-Container-Bytes-Used-Actual: 20971520
>         X-Storage-Policy: default-placement
>         X-Trans-Id: ts-default.64171.100-20150916:024200:482
>         Content-Length: 9
>         Accept-Ranges: bytes
>         Content-type: text/plain; charset=3Dutf-8
>         Date: Wed, 16 Sep 2015 02:42:00 GMT
>
>         file_test

Sounds like another bug, can you open tickets for the relevant bugs?

Thanks,
Yehuda

>
> As you can see, the container has only one object of 20M, but the acc=
ount owns two objects of 40M in total. I checked the .rgw.buckets pool =
and it contains only one file:
>         sandy@ceph20:~$ rados -p .rgw.buckets ls
>         default.64171.1__shadow_.bSI8b1u0Wff4-2LuEDCYtYkqhpuqPAK_4
>         default.64171.1__shadow_.bSI8b1u0Wff4-2LuEDCYtYkqhpuqPAK_1
>         default.64171.1__shadow_.bSI8b1u0Wff4-2LuEDCYtYkqhpuqPAK_5
>         default.64171.1__shadow_.bSI8b1u0Wff4-2LuEDCYtYkqhpuqPAK_3
>         default.64171.1_file_test
>         default.64171.1__shadow_.bSI8b1u0Wff4-2LuEDCYtYkqhpuqPAK_2
>
>
> Your comments and suggestions would be sincerely appreciated, thank y=
ou.
>
> -----
> Best regards,
> Sangdi
> ---------------------------------------------------------------------=
----------------------------------------------------------------
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=
=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=
=BA
> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=
=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=
=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=
=81
> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=
=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=
=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=
=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC
> =E9=82=AE=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from=
 H3C, which is
> intended only for the person or entity whose address is listed above.=
 Any use of the
> information contained herein in any way (including, but not limited t=
o, total or partial
> disclosure, reproduction, or dissemination) by persons other than the=
 intended
> recipient(s) is prohibited. If you receive this e-mail in error, plea=
se notify the sender
> by phone or email immediately and delete it!
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
