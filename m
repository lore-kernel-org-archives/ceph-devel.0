From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: radosgw Segmentation fault on obj copy
Date: Tue, 3 Dec 2013 05:39:54 +0100
Message-ID: <CAMNMNTwqqHTAv2kVMLPWcw22R1OKTr8preiXSSVS7jqE2jr8RA@mail.gmail.com>
References: <CAMNMNTzEVkom0cBe_jepaE95hzVGys+8y+-PA+2dSsTqNwg=tA@mail.gmail.com>
	<CAMNMNTzx_CHmYRXXE-KhbEwNZqLAAcTBp-5SZks7UiQ+OS1XqA@mail.gmail.com>
	<CABBk=J-HAPxi4eg0AW_vD0T+QoqRzBMchpovM9s+EhzzC2ZZmg@mail.gmail.com>
	<CAMNMNTzMvb-udVW5LrOhJLCSWWP5KVMHHyLrHwsY=bv3ckXyGA@mail.gmail.com>
	<CABBk=J-xw8G5Uuj1HGonP-B_Xzqn=A0myE-C28sWMMpnH9tbmA@mail.gmail.com>
	<CAMNMNTxYE=nqg04X7Wa0U2g3iW-HfkDBCEY_fv75D+nE7=xz4w@mail.gmail.com>
	<CABBk=J8emXQJQvoUhKQVEWUqs3=z_sP-4ADgo7aAaVNORrYh_g@mail.gmail.com>
	<CAMNMNTy8VqNQRtbW-dvGd0A2vmWtP+ty0d9ezB4ed+fj-3Qf_A@mail.gmail.com>
	<CABBk=J8GeCckYaxFu+_8jwagKtt2vOkmMsQ=1vii+MR7-erYjQ@mail.gmail.com>
	<CABBk=J9a3M6yAZj40+XZKLfmoHj7xsYj3GTfs34Be8twSb19UQ@mail.gmail.com>
	<CAMNMNTwk=q0aStrqJACqnB64AhGSH13LwNGzb3hC1DQMeZtwOg@mail.gmail.com>
	<CABBk=J9MQESKAySjaObEK21zxJadLgUWi-AnrVh=XQdN8eLC1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:47387 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3LCEjz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Dec 2013 23:39:55 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so13965076obb.3
        for <ceph-devel@vger.kernel.org>; Mon, 02 Dec 2013 20:39:54 -0800 (PST)
In-Reply-To: <CABBk=J9MQESKAySjaObEK21zxJadLgUWi-AnrVh=XQdN8eLC1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

for another object.
http://pastebin.com/VkVAYgwn


2013/12/3 Yehuda Sadeh <yehuda@inktank.com>:
> I see. Do you have backtrace for the crash?
>
> On Mon, Dec 2, 2013 at 6:19 PM, Dominik Mostowiec
> <dominikmostowiec@gmail.com> wrote:
>> 0.56.7
>>
>> W dniu poniedzia=B3ek, 2 grudnia 2013 u=BFytkownik Yehuda Sadeh napi=
sa=B3:
>>
>>> I'm having trouble reproducing the issue. What version are you usin=
g?
>>>
>>> Thanks,
>>> Yehuda
>>>
>>> On Mon, Dec 2, 2013 at 2:16 PM, Yehuda Sadeh <yehuda@inktank.com> w=
rote:
>>> > Actually, I read that differently. It only says that if there's m=
ore
>>> > than 1 part, all parts except for the last one need to be > 5M. W=
hich
>>> > means that for uploads that are smaller than 5M there should be z=
ero
>>> > or one parts.
>>> >
>>> > On Mon, Dec 2, 2013 at 12:54 PM, Dominik Mostowiec
>>> > <dominikmostowiec@gmail.com> wrote:
>>> >> You're right.
>>> >>
>>> >> S3 api doc:
>>> >> http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadComplete.=
html
>>> >> "Err:EntityTooSmall
>>> >> Your proposed upload is smaller than the minimum allowed object =
size.
>>> >> Each part must be at least 5 MB in size, except the last part."
>>> >>
>>> >> Thanks.
>>> >>
>>> >> This error should be triggered from radosgw also.
>>> >>
>>> >> --
>>> >> Regards
>>> >> Dominik
>>> >>
>>> >> 2013/12/2 Yehuda Sadeh <yehuda@inktank.com>:
>>> >>> Looks like it. There should be a guard against it (mulitpart up=
load
>>> >>> minimum is 5M).
>>> >>>
>>> >>> On Mon, Dec 2, 2013 at 12:32 PM, Dominik Mostowiec
>>> >>> <dominikmostowiec@gmail.com> wrote:
>>> >>>> Yes, this is probably upload empty file.
>>> >>>> This is the problem?
>>> >>>>
>>> >>>> --
>>> >>>> Regards
>>> >>>> Dominik
>>> >>>>
>>> >>>>
>>> >>>> 2013/12/2 Yehuda Sadeh <yehuda@inktank.com>:
>>> >>>>> By any chance are you uploading empty objects through the mul=
tipart
>>> >>>>> upload api?
>>> >>>>>
>>> >>>>> On Mon, Dec 2, 2013 at 12:08 PM, Dominik Mostowiec
>>> >>>>> <dominikmostowiec@gmail.com> wrote:
>>> >>>>>> Hi,
>>> >>>>>> Another file with the same problems:
>>> >>>>>>
>>> >>>>>> 2013-12-01 11:37:15.556687 7f7891fd3700  1 =3D=3D=3D=3D=3D=3D=
 starting new
>>> >>>>>> request
>>> >>>>>> req=3D0x25406d0 =3D=3D=3D=3D=3D
>>> >>>>>> 2013-12-01 11:37:15.556739 7f7891fd3700  2 req
>>> >>>>>> 1314:0.000052::::initializing
>>> >>>>>> 2013-12-01 11:37:15.556789 7f7891fd3700 10 s->object=3Dfiles=
/192.txt
>>> >>>>>> s->bucket=3Dtestbucket
>>> >>>>>> 2013-12-01 11:37:15.556799 7f7891fd3700  2 req
>>> >>>>>> 1314:0.000112:s3:POST
>>> >>>>>> /testbucket/files/192.txt::getting op
>>> >>>>>> 2013-12-01 11:37:15.556804 7f7891fd3700  2 req
>>> >>>>>> 1314:0.000118:s3:POST
>>> >>>>>> /testbucket/files/192.txt:complete_multipart:authorizing
>>> >>>>>> 2013-12-01 11:37:15.560013 7f7891fd3700 10 get_canon_resourc=
e():
>>> >>>>>>
>>> >>>>>> dest=3D/testbucket/files/192.txt?uploadId=3Di92xi2olzDtFAeLX=
lfU2PFP9CDU87BC
>>> >>>>>> 2013-12-01 11:37:15.560027 7f7891fd3700 10 auth_hdr:
>>> >>>>>> POST
>>> >>>>>>
>>> >>>>>> application/xml
>>> >>>>>> Sun, 01 Dec 2013 10:37:10 GMT
>>> >>>>>> /testbucket/files/192.txt?uploadId=3Di92xi2olzDtFAeLXlfU2PFP=
9CDU87BC
>>> >>>>>> 2013-12-01 11:37:15.560085 7f7891fd3700  2 req
>>> >>>>>> 1314:0.003399:s3:POST
>>> >>>>>> /testbucket/files/192.txt:complete_multipart:reading permiss=
ions
>>> >>>>>> 2013-12-01 11:37:15.562356 7f7891fd3700  2 req
>>> >>>>>> 1314:0.005670:s3:POST
>>> >>>>>> /testbucket/files/192.txt:complete_multipart:verifying op
>>> >>>>>> permissions
>>> >>>>>> 2013-12-01 11:37:15.562373 7f7891fd3700  5 Searching permiss=
ions
>>> >>>>>> for
>>> >>>>>> uid=3D0 mask=3D2
>>> >>>>>> 2013-12-01 11:37:15.562377 7f7891fd3700  5 Found permission:=
 15
>>> >>>>>> 2013-12-01 11:37:15.562378 7f7891fd3700 10  uid=3D0 requeste=
d perm
>>> >>>>>> (type)=3D2, policy perm=3D2, user_perm_mask=3D2, acl perm=3D=
2
>>> >>>>>> 2013-12-01 11:37:15.562381 7f7891fd3700  2 req
>>> >>>>>> 1314:0.005695:s3:POST
>>> >>>>>> /testbucket/files/192.txt:complete_multipart:verifying op pa=
rams
>>> >>>>>> 2013-12-01 11:37:15.562384 7f7891fd3700  2 req
>>> >>>>>> 1314:0.005698:s3:POST
>>> >>>>>> /testbucket/files/192.txt:complete_multipart:executing
>>> >>>>>> 2013-12-01 11:37:15.565461 7f7891fd3700 10 calculated etag:
>>> >>>>>> d41d8cd98f00b204e9800998ecf8427e-0
>>> >>>>>> 2013-12-01 11:37:15.566718 7f7891fd3700 10 can't clone objec=
t
>>> >>>>>> testbucket:files/192.txt to shadow object, tag/shadow_obj ha=
ven't
>>> >>>>>> been
>>> >>>>>> set
>>> >>>>>> 2013-12-01 11:37:15.566777 7f7891fd3700  0 setting object
>>> >>>>>> tag=3D_leyAzxCw7YxpKv8P3v3QGwcsw__9VmP
>>> >>>>>> 2013-12-01 11:37:15.678973 7f7891fd3700  2 req
>>> >>>>>> 1314:0.122286:s3:POST
>>> >>>>>> /testbucket/files/192.txt:complete_multipart:http status=3D2=
00
>>> >>>>>> 2013-12-01 11:37:15.679192 7f7891fd3700  1 =3D=3D=3D=3D=3D=3D=
 req done
>>> >>>>>> req=3D0x25406d0 http_status=3D200 =3D=3D=3D=3D=3D=3D
>>> >>>>>>
>>> >>>>>> Yes, I can read oryginal object.
>>> >>>>>>
>>> >>>>>> --
>>> >>>>>> Regards
>>> >>>>>> Dominik
>>> >>>>>>
>>> >>>>>> 2013/12/2 Yehuda Sadeh <yehuda@inktank.com>:
>>> >>>>>>> That's unknown bug. I have a guess as to how the original o=
bject
>>> >>>>>>> was
>>> >>>>>>> created. Can you read the original object, but only copy fa=
ils?
>>> >>>>>>>
>>> >>>>>>> On Dec 2, 2013 4:53 AM, "Dominik Mostowiec"
>>> >>>>>>> <dominikmostowiec@gmail.com>
>>> >>>>>>> wrote:
>>> >>>>>>>>
>>> >>>>>>>> Hi,
>>> >>>>>>>> I found that issue is related with "ETag: ....-0" (ends -0=
)
>>> >>>>>>>> This is known bug ?
>>> >>>>>>>>
>>> >>>>>>>> --
>>> >>>>>>>> Regards
>>> >>>>>>>> Dominik
>>> >>>>>>>>
>>> >>>>>>>> 2013/12/2 Dominik Mostowiec <dominikmostowiec@gmail.com>:
>>> >>>>>>>> > Hi,
>>> >>>>>>>> > I have strange problem.
>>> >>>>>>>> > Obj copy (0 size) killing radosgw.
>>> >>>>>>>> >
>>> >>>>>>>> > Head for this file:
>>> >>>>>>>> > Content-Type: application/octet-stream
>>> >>>>>>>> > Server: Apache/2.2.22 (Ubuntu)
>>> >>>>>>>> > ETag: "d41d8cd98f00b204e9800998ecf8427e-0"
>>> >>>>>>>> > Last-Modified: 2013-12-01T10:37:15Z
>>> >>>>>>>> >
>>> >>>>>>>> > rgw log.
>>> >>>>>>>> > 2013-12-02 08:18:59.196651 7f5308ff1700  1 =3D=3D=3D=3D=3D=
=3D starting new
>>> >>>>>>>> > request
>>> >>>>>>>> > req=3D0x2be6fa0 =3D=3D=3D=3D=3D
>>> >>>>>>>> > 2013-12-02 08:18:59.196709 7f5308ff1700  2 req
>>> >>>>>>>> > 237:0.000058::::initializing
>>> >>>>>>>> > 2013-12-02 08:18:59.196752 7f5308ff1700 10 meta>>
>>> >>>>>>>> > HTTP_X_AMZ_ACL=3Dpublic-read
>>> >>>>>>>> > 2013-12-02 08:18:59.196760 7f5308ff1700 10 meta>>
>>> >>>>>>>> > HTTP_X_AMZ_COPY_SOURCE=3D/testbucket/testfile.xml
>>> >>>>>>>> > 2013-12-02 08:18:59.196766 7f5308ff1700 10 meta>>
>>> >>>>>>>> > HTTP_X_AMZ_METADATA_DIRECTIVE=3DCOPY
>>> >>>>>>>> > 2013-12-02 08:18:59.196771 7f5308ff1700 10 x>>
>>> >>>>>>>> > x-amz-acl:public-read
>>> >>>>>>>> > 2013-12-02 08:18:59.196772 7f5308ff1700 10 x>>
>>> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
>>> >>>>>>>> > 2013-12-02 08:18:59.196773 7f5308ff1700 10 x>>
>>> >>>>>>>> > x-amz-metadata-directive:COPY
>>> >>>>>>>> > 2013-12-02 08:18:59.196786 7f5308ff1700 10
>>> >>>>>>>> > s->object=3D/testbucket/new_testfile.ini s->bucket=3Dtes=
tbucket
>>> >>>>>>>> > 2013-12-02 08:18:59.196792 7f5308ff1700  2 req
>>> >>>>>>>> > 237:0.000141:s3:PUT
>>> >>>>>>>> > /testbucket/new_testfile.ini::getting op
>>> >>>>>>>> > 2013-12-02 08:18:59.196797 7f5308ff1700  2 req
>>> >>>>>>>> > 237:0.000146:s3:PUT
>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:authorizing
>>> >>>>>>>> > 2013-12-02 08:18:59.200648 7f5308ff1700 10
>>> >>>>>>>> > get_canon_resource():
>>> >>>>>>>> > dest=3D/testbucket/new_testfile.ini
>>> >>>>>>>> > 2013-12-02 08:18:59.200661 7f5308ff1700 10 auth_hdr:
>>> >>>>>>>> > PUT
>>> >>>>>>>> > 1B2M2Y8AsgTpgAmY7PhCfg=3D=3D
>>> >>>>>>>> > application/octet-stream
>>> >>>>>>>> > Mon, 02 Dec 2013 07:18:55 GMT
>>> >>>>>>>> > x-amz-acl:public-read
>>> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
>>> >>>>>>>> > x-amz-metadata-directive:COPY
>>> >>>>>>>> > /testbucket/new_testfile.ini
>>> >>>>>>>> > 2013-12-02 08:18:59.200717 7f5308ff1700  2 req
>>> >>>>>>>> > 237:0.004066:s3:PUT
>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:reading permission=
s
>>> >>>>>>>> > 2013-12-02 08:18:59.203330 7f5308ff1700  2 req
>>> >>>>>>>> > 237:0.006679:s3:PUT
>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:verifying op permi=
ssions
>>> >>>>>>>> > 2013-12-02 08:18:59.207627 7f5308ff1700 10 manifest: tot=
al_size
>>> >>>>>>>> > =3D 0
>>> >>>>>>>> > 2013-12-02 08:18:59.207649 7f5308ff1700  5 Searching
>>> >>>>>>>> > permissions for
>>> >>>>>>>> > uid=3D0 mask=3D1
>>> >>>>>>>> > 2013-12-02 08:18:59.207652 7f5308ff1700  5 Found permiss=
ion: 15
>>> >>>>>>>> > 2013-12-02 08:18:59.207654 7f5308ff1700 10  uid=3D0 requ=
ested
>>> >>>>>>>> > perm
>>> >>>>>>>> > (type)=3D1, policy perm=3D1, user_perm_mask=3D15, acl pe=
rm=3D1
>>> >>>>>>>> > 2013-12-02 08:18:59.207669 7f5308ff1700  5 Searching
>>> >>>>>>>> > permissions for
>>> >>>>>>>> > uid=3D0 mask=3D2
>>> >>>>>>>> > 2013-12-02 08:18:59.207670 7f5308ff1700  5 Found permiss=
ion: 15
>>> >>>>>>>> > 2013-12-02 08:18:59.207671 7f5308ff1700 10  uid=3D0 requ=
ested
>>> >>>>>>>> > perm
>>> >>>>>>>> > (type)=3D2, policy perm=3D2, user_perm_mask=3D15, acl pe=
rm=3D2
>>> >>>>>>>> > 2013-12-02 08:18:59.207681 7f5308ff1700  2 req
>>> >>>>>>>> > 237:0.011030:s3:PUT
>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:verifying op param=
s
>>> >>>>>>>> > 2013-12-02 08:18:59.207686 7f5308ff1700  2 req
>>> >>>>>>>> > 237:0.011035:s3:PUT
>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:executing
>>> >>>>>>>> > 2013-12-02 08:18:59.207699 7f5308ff1700 10 x>>
>>> >>>>>>>> > x-amz-acl:public-read
>>> >>>>>>>> > 2013-12-02 08:18:59.207704 7f5308ff1700 10 x>>
>>> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
>>> >>>>>>>> > 2013-12-02 08:18:59.207709 7f5308ff1700 10 x>>
>>> >>>>>>>> > x-amz-metadata-directive:COPY
>>> >>>>>>>> > 2013-12-02 08:18:59.207759 7f5308ff1700  5 Copy object
>>> >>>>>>>> > testbucket(@.rgw.buckets[406250.1]):testfile.ini =3D>
>>> >>>>>>>> > testbucket(@.rgw.buckets[406250.1]):new_testfile.ini
>>> >>>>>>>> > 2013-12-02 08:18:59.208903 7f5308ff1700 -1 *** Caught si=
gnal
>>> >>>>>>>> > (Segmentation fault) **
>>> >>>>>>>> >  in thread 7f5308ff1700
>>> >>>>>>>> >
>>> >>>>>>>> >
>>> >>>>>>>> > --
>>> >>>>>>>> > Regards
>>> >>>>>>>> > Dominik
>>> >>>>>>>>
>>> >>>>>>>>
>>> >>>>>>>>
>>> >>>>>>>> --
>>> >>>>>>>> Pozdrawiam
>>> >>>>>>>> Dominik
>>> >>>>>>>> _______________________________________________
>>> >>>>>>>> ceph-users mailing list
>>> >>>>>>>> ceph-users@lists.ceph.com
>>> >>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> >>>>>>
>>> >>>>>>
>>> >>>>>>
>>> >>>>>> --
>>> >>>>>> Pozdrawiam
>>> >>>>>> Dominik
>>> >>>>
>>> >>>>
>>> >>>>
>>> >>>> --
>>> >>>> Pozdrawiam
>>> >>>> Dominik
>>> >>
>>> >>
>>> >>
>>> >> --
>>> >> Pozdrawiam
>>> >> Dominik
>>
>>
>>
>> --
>> Pozdrawiam
>> Dominik



--=20
Pozdrawiam
Dominik
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
