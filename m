From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: radosgw Segmentation fault on obj copy
Date: Tue, 3 Dec 2013 07:24:09 +0100
Message-ID: <CAMNMNTyaUy_Tr6V9TDn2QHMf1oR_MXyPzwy5f8cg_=js9ZxCUg@mail.gmail.com>
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
	<CAMNMNTwqqHTAv2kVMLPWcw22R1OKTr8preiXSSVS7jqE2jr8RA@mail.gmail.com>
	<CABBk=J8E7eiViy3KMcTmrZgb5rUnXQigYKGkD+kRhbAH2gP2Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1834890696=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABBk=J8E7eiViy3KMcTmrZgb5rUnXQigYKGkD+kRhbAH2gP2Bw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1834890696==
Content-Type: multipart/alternative; boundary=f46d044481a520f6b804ec9b588a

--f46d044481a520f6b804ec9b588a
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Thanks
Workaround, don't use multipart when obj size =3D=3D 0 ?
On Dec 3, 2013 6:43 AM, "Yehuda Sadeh" <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> I created earlier an issue (6919) and updated it with the relevant
> issue. This has been fixed in dumpling, although I don't remember
> hitting the scenario that you did. Was probably hitting it as part of
> the development work that was done then.
> In any case I created a branch with the relevant fixes in it (wip-6919).
>
> Thanks,
> Yehuda
>
> On Mon, Dec 2, 2013 at 8:39 PM, Dominik Mostowiec
> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > for another object.
> > http://pastebin.com/VkVAYgwn
> >
> >
> > 2013/12/3 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >> I see. Do you have backtrace for the crash?
> >>
> >> On Mon, Dec 2, 2013 at 6:19 PM, Dominik Mostowiec
> >> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>> 0.56.7
> >>>
> >>> W dniu poniedzia=B3ek, 2 grudnia 2013 u=BFytkownik Yehuda Sadeh napis=
a=B3:
> >>>
> >>>> I'm having trouble reproducing the issue. What version are you using=
?
> >>>>
> >>>> Thanks,
> >>>> Yehuda
> >>>>
> >>>> On Mon, Dec 2, 2013 at 2:16 PM, Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
> wrote:
> >>>> > Actually, I read that differently. It only says that if there's mo=
re
> >>>> > than 1 part, all parts except for the last one need to be > 5M.
> Which
> >>>> > means that for uploads that are smaller than 5M there should be ze=
ro
> >>>> > or one parts.
> >>>> >
> >>>> > On Mon, Dec 2, 2013 at 12:54 PM, Dominik Mostowiec
> >>>> > <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>> >> You're right.
> >>>> >>
> >>>> >> S3 api doc:
> >>>> >>
> http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadComplete.html
> >>>> >> "Err:EntityTooSmall
> >>>> >> Your proposed upload is smaller than the minimum allowed object
> size.
> >>>> >> Each part must be at least 5 MB in size, except the last part."
> >>>> >>
> >>>> >> Thanks.
> >>>> >>
> >>>> >> This error should be triggered from radosgw also.
> >>>> >>
> >>>> >> --
> >>>> >> Regards
> >>>> >> Dominik
> >>>> >>
> >>>> >> 2013/12/2 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >>>> >>> Looks like it. There should be a guard against it (mulitpart
> upload
> >>>> >>> minimum is 5M).
> >>>> >>>
> >>>> >>> On Mon, Dec 2, 2013 at 12:32 PM, Dominik Mostowiec
> >>>> >>> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>> >>>> Yes, this is probably upload empty file.
> >>>> >>>> This is the problem?
> >>>> >>>>
> >>>> >>>> --
> >>>> >>>> Regards
> >>>> >>>> Dominik
> >>>> >>>>
> >>>> >>>>
> >>>> >>>> 2013/12/2 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >>>> >>>>> By any chance are you uploading empty objects through the
> multipart
> >>>> >>>>> upload api?
> >>>> >>>>>
> >>>> >>>>> On Mon, Dec 2, 2013 at 12:08 PM, Dominik Mostowiec
> >>>> >>>>> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>> >>>>>> Hi,
> >>>> >>>>>> Another file with the same problems:
> >>>> >>>>>>
> >>>> >>>>>> 2013-12-01 11:37:15.556687 7f7891fd3700  1 =3D=3D=3D=3D=3D=3D=
 starting new
> >>>> >>>>>> request
> >>>> >>>>>> req=3D0x25406d0 =3D=3D=3D=3D=3D
> >>>> >>>>>> 2013-12-01 11:37:15.556739 7f7891fd3700  2 req
> >>>> >>>>>> 1314:0.000052::::initializing
> >>>> >>>>>> 2013-12-01 11:37:15.556789 7f7891fd3700 10
> s->object=3Dfiles/192.txt
> >>>> >>>>>> s->bucket=3Dtestbucket
> >>>> >>>>>> 2013-12-01 11:37:15.556799 7f7891fd3700  2 req
> >>>> >>>>>> 1314:0.000112:s3:POST
> >>>> >>>>>> /testbucket/files/192.txt::getting op
> >>>> >>>>>> 2013-12-01 11:37:15.556804 7f7891fd3700  2 req
> >>>> >>>>>> 1314:0.000118:s3:POST
> >>>> >>>>>> /testbucket/files/192.txt:complete_multipart:authorizing
> >>>> >>>>>> 2013-12-01 11:37:15.560013 7f7891fd3700 10
> get_canon_resource():
> >>>> >>>>>>
> >>>> >>>>>>
> dest=3D/testbucket/files/192.txt?uploadId=3Di92xi2olzDtFAeLXlfU2PFP9CDU87=
BC
> >>>> >>>>>> 2013-12-01 11:37:15.560027 7f7891fd3700 10 auth_hdr:
> >>>> >>>>>> POST
> >>>> >>>>>>
> >>>> >>>>>> application/xml
> >>>> >>>>>> Sun, 01 Dec 2013 10:37:10 GMT
> >>>> >>>>>>
> /testbucket/files/192.txt?uploadId=3Di92xi2olzDtFAeLXlfU2PFP9CDU87BC
> >>>> >>>>>> 2013-12-01 11:37:15.560085 7f7891fd3700  2 req
> >>>> >>>>>> 1314:0.003399:s3:POST
> >>>> >>>>>> /testbucket/files/192.txt:complete_multipart:reading
> permissions
> >>>> >>>>>> 2013-12-01 11:37:15.562356 7f7891fd3700  2 req
> >>>> >>>>>> 1314:0.005670:s3:POST
> >>>> >>>>>> /testbucket/files/192.txt:complete_multipart:verifying op
> >>>> >>>>>> permissions
> >>>> >>>>>> 2013-12-01 11:37:15.562373 7f7891fd3700  5 Searching
> permissions
> >>>> >>>>>> for
> >>>> >>>>>> uid=3D0 mask=3D2
> >>>> >>>>>> 2013-12-01 11:37:15.562377 7f7891fd3700  5 Found permission: =
15
> >>>> >>>>>> 2013-12-01 11:37:15.562378 7f7891fd3700 10  uid=3D0 requested
> perm
> >>>> >>>>>> (type)=3D2, policy perm=3D2, user_perm_mask=3D2, acl perm=3D2
> >>>> >>>>>> 2013-12-01 11:37:15.562381 7f7891fd3700  2 req
> >>>> >>>>>> 1314:0.005695:s3:POST
> >>>> >>>>>> /testbucket/files/192.txt:complete_multipart:verifying op
> params
> >>>> >>>>>> 2013-12-01 11:37:15.562384 7f7891fd3700  2 req
> >>>> >>>>>> 1314:0.005698:s3:POST
> >>>> >>>>>> /testbucket/files/192.txt:complete_multipart:executing
> >>>> >>>>>> 2013-12-01 11:37:15.565461 7f7891fd3700 10 calculated etag:
> >>>> >>>>>> d41d8cd98f00b204e9800998ecf8427e-0
> >>>> >>>>>> 2013-12-01 11:37:15.566718 7f7891fd3700 10 can't clone object
> >>>> >>>>>> testbucket:files/192.txt to shadow object, tag/shadow_obj
> haven't
> >>>> >>>>>> been
> >>>> >>>>>> set
> >>>> >>>>>> 2013-12-01 11:37:15.566777 7f7891fd3700  0 setting object
> >>>> >>>>>> tag=3D_leyAzxCw7YxpKv8P3v3QGwcsw__9VmP
> >>>> >>>>>> 2013-12-01 11:37:15.678973 7f7891fd3700  2 req
> >>>> >>>>>> 1314:0.122286:s3:POST
> >>>> >>>>>> /testbucket/files/192.txt:complete_multipart:http status=3D20=
0
> >>>> >>>>>> 2013-12-01 11:37:15.679192 7f7891fd3700  1 =3D=3D=3D=3D=3D=3D=
 req done
> >>>> >>>>>> req=3D0x25406d0 http_status=3D200 =3D=3D=3D=3D=3D=3D
> >>>> >>>>>>
> >>>> >>>>>> Yes, I can read oryginal object.
> >>>> >>>>>>
> >>>> >>>>>> --
> >>>> >>>>>> Regards
> >>>> >>>>>> Dominik
> >>>> >>>>>>
> >>>> >>>>>> 2013/12/2 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >>>> >>>>>>> That's unknown bug. I have a guess as to how the original
> object
> >>>> >>>>>>> was
> >>>> >>>>>>> created. Can you read the original object, but only copy
> fails?
> >>>> >>>>>>>
> >>>> >>>>>>> On Dec 2, 2013 4:53 AM, "Dominik Mostowiec"
> >>>> >>>>>>> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>> >>>>>>> wrote:
> >>>> >>>>>>>>
> >>>> >>>>>>>> Hi,
> >>>> >>>>>>>> I found that issue is related with "ETag: ....-0" (ends -0)
> >>>> >>>>>>>> This is known bug ?
> >>>> >>>>>>>>
> >>>> >>>>>>>> --
> >>>> >>>>>>>> Regards
> >>>> >>>>>>>> Dominik
> >>>> >>>>>>>>
> >>>> >>>>>>>> 2013/12/2 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>>> >>>>>>>> > Hi,
> >>>> >>>>>>>> > I have strange problem.
> >>>> >>>>>>>> > Obj copy (0 size) killing radosgw.
> >>>> >>>>>>>> >
> >>>> >>>>>>>> > Head for this file:
> >>>> >>>>>>>> > Content-Type: application/octet-stream
> >>>> >>>>>>>> > Server: Apache/2.2.22 (Ubuntu)
> >>>> >>>>>>>> > ETag: "d41d8cd98f00b204e9800998ecf8427e-0"
> >>>> >>>>>>>> > Last-Modified: 2013-12-01T10:37:15Z
> >>>> >>>>>>>> >
> >>>> >>>>>>>> > rgw log.
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196651 7f5308ff1700  1 =3D=3D=3D=3D=
=3D=3D starting
> new
> >>>> >>>>>>>> > request
> >>>> >>>>>>>> > req=3D0x2be6fa0 =3D=3D=3D=3D=3D
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196709 7f5308ff1700  2 req
> >>>> >>>>>>>> > 237:0.000058::::initializing
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196752 7f5308ff1700 10 meta>>
> >>>> >>>>>>>> > HTTP_X_AMZ_ACL=3Dpublic-read
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196760 7f5308ff1700 10 meta>>
> >>>> >>>>>>>> > HTTP_X_AMZ_COPY_SOURCE=3D/testbucket/testfile.xml
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196766 7f5308ff1700 10 meta>>
> >>>> >>>>>>>> > HTTP_X_AMZ_METADATA_DIRECTIVE=3DCOPY
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196771 7f5308ff1700 10 x>>
> >>>> >>>>>>>> > x-amz-acl:public-read
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196772 7f5308ff1700 10 x>>
> >>>> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196773 7f5308ff1700 10 x>>
> >>>> >>>>>>>> > x-amz-metadata-directive:COPY
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196786 7f5308ff1700 10
> >>>> >>>>>>>> > s->object=3D/testbucket/new_testfile.ini s->bucket=3Dtest=
bucket
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196792 7f5308ff1700  2 req
> >>>> >>>>>>>> > 237:0.000141:s3:PUT
> >>>> >>>>>>>> > /testbucket/new_testfile.ini::getting op
> >>>> >>>>>>>> > 2013-12-02 08:18:59.196797 7f5308ff1700  2 req
> >>>> >>>>>>>> > 237:0.000146:s3:PUT
> >>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:authorizing
> >>>> >>>>>>>> > 2013-12-02 08:18:59.200648 7f5308ff1700 10
> >>>> >>>>>>>> > get_canon_resource():
> >>>> >>>>>>>> > dest=3D/testbucket/new_testfile.ini
> >>>> >>>>>>>> > 2013-12-02 08:18:59.200661 7f5308ff1700 10 auth_hdr:
> >>>> >>>>>>>> > PUT
> >>>> >>>>>>>> > 1B2M2Y8AsgTpgAmY7PhCfg=3D=3D
> >>>> >>>>>>>> > application/octet-stream
> >>>> >>>>>>>> > Mon, 02 Dec 2013 07:18:55 GMT
> >>>> >>>>>>>> > x-amz-acl:public-read
> >>>> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
> >>>> >>>>>>>> > x-amz-metadata-directive:COPY
> >>>> >>>>>>>> > /testbucket/new_testfile.ini
> >>>> >>>>>>>> > 2013-12-02 08:18:59.200717 7f5308ff1700  2 req
> >>>> >>>>>>>> > 237:0.004066:s3:PUT
> >>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:reading permissions
> >>>> >>>>>>>> > 2013-12-02 08:18:59.203330 7f5308ff1700  2 req
> >>>> >>>>>>>> > 237:0.006679:s3:PUT
> >>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:verifying op
> permissions
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207627 7f5308ff1700 10 manifest:
> total_size
> >>>> >>>>>>>> > =3D 0
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207649 7f5308ff1700  5 Searching
> >>>> >>>>>>>> > permissions for
> >>>> >>>>>>>> > uid=3D0 mask=3D1
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207652 7f5308ff1700  5 Found
> permission: 15
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207654 7f5308ff1700 10  uid=3D0 reque=
sted
> >>>> >>>>>>>> > perm
> >>>> >>>>>>>> > (type)=3D1, policy perm=3D1, user_perm_mask=3D15, acl per=
m=3D1
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207669 7f5308ff1700  5 Searching
> >>>> >>>>>>>> > permissions for
> >>>> >>>>>>>> > uid=3D0 mask=3D2
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207670 7f5308ff1700  5 Found
> permission: 15
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207671 7f5308ff1700 10  uid=3D0 reque=
sted
> >>>> >>>>>>>> > perm
> >>>> >>>>>>>> > (type)=3D2, policy perm=3D2, user_perm_mask=3D15, acl per=
m=3D2
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207681 7f5308ff1700  2 req
> >>>> >>>>>>>> > 237:0.011030:s3:PUT
> >>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:verifying op params
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207686 7f5308ff1700  2 req
> >>>> >>>>>>>> > 237:0.011035:s3:PUT
> >>>> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:executing
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207699 7f5308ff1700 10 x>>
> >>>> >>>>>>>> > x-amz-acl:public-read
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207704 7f5308ff1700 10 x>>
> >>>> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207709 7f5308ff1700 10 x>>
> >>>> >>>>>>>> > x-amz-metadata-directive:COPY
> >>>> >>>>>>>> > 2013-12-02 08:18:59.207759 7f5308ff1700  5 Copy object
> >>>> >>>>>>>> > testbucket(@.rgw.buckets[406250.1]):testfile.ini =3D>
> >>>> >>>>>>>> > testbucket(@.rgw.buckets[406250.1]):new_testfile.ini
> >>>> >>>>>>>> > 2013-12-02 08:18:59.208903 7f5308ff1700 -1 *** Caught
> signal
> >>>> >>>>>>>> > (Segmentation fault) **
> >>>> >>>>>>>> >  in thread 7f5308ff1700
> >>>> >>>>>>>> >
> >>>> >>>>>>>> >
> >>>> >>>>>>>> > --
> >>>> >>>>>>>> > Regards
> >>>> >>>>>>>> > Dominik
> >>>> >>>>>>>>
> >>>> >>>>>>>>
> >>>> >>>>>>>>
> >>>> >>>>>>>> --
> >>>> >>>>>>>> Pozdrawiam
> >>>> >>>>>>>> Dominik
> >>>> >>>>>>>> _______________________________________________
> >>>> >>>>>>>> ceph-users mailing list
> >>>> >>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>> >>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>> >>>>>>
> >>>> >>>>>>
> >>>> >>>>>>
> >>>> >>>>>> --
> >>>> >>>>>> Pozdrawiam
> >>>> >>>>>> Dominik
> >>>> >>>>
> >>>> >>>>
> >>>> >>>>
> >>>> >>>> --
> >>>> >>>> Pozdrawiam
> >>>> >>>> Dominik
> >>>> >>
> >>>> >>
> >>>> >>
> >>>> >> --
> >>>> >> Pozdrawiam
> >>>> >> Dominik
> >>>
> >>>
> >>>
> >>> --
> >>> Pozdrawiam
> >>> Dominik
> >
> >
> >
> > --
> > Pozdrawiam
> > Dominik
>

--f46d044481a520f6b804ec9b588a
Content-Type: text/html; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thanks<br>
Workaround, don&#39;t use multipart when obj size =3D=3D 0 ?</p>
<div class=3D"gmail_quote">On Dec 3, 2013 6:43 AM, &quot;Yehuda Sadeh&quot;=
 &lt;<a href=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote=
:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
I created earlier an issue (6919) and updated it with the relevant<br>
issue. This has been fixed in dumpling, although I don&#39;t remember<br>
hitting the scenario that you did. Was probably hitting it as part of<br>
the development work that was done then.<br>
In any case I created a branch with the relevant fixes in it (wip-6919).<br=
>
<br>
Thanks,<br>
Yehuda<br>
<br>
On Mon, Dec 2, 2013 at 8:39 PM, Dominik Mostowiec<br>
&lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmostowiec-Re5JQEeQqe8@public.gmane.org=
m</a>&gt; wrote:<br>
&gt; for another object.<br>
&gt; <a href=3D"http://pastebin.com/VkVAYgwn" target=3D"_blank">http://past=
ebin.com/VkVAYgwn</a><br>
&gt;<br>
&gt;<br>
&gt; 2013/12/3 Yehuda Sadeh &lt;<a href=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehud=
a@inktank.com</a>&gt;:<br>
&gt;&gt; I see. Do you have backtrace for the crash?<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Dec 2, 2013 at 6:19 PM, Dominik Mostowiec<br>
&gt;&gt; &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmostowiec=
@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; 0.56.7<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; W dniu poniedzia=B3ek, 2 grudnia 2013 u=BFytkownik Yehuda Sade=
h napisa=B3:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I&#39;m having trouble reproducing the issue. What version=
 are you using?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt; Yehuda<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Mon, Dec 2, 2013 at 2:16 PM, Yehuda Sadeh &lt;<a href=
=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; &gt; Actually, I read that differently. It only says that =
if there&#39;s more<br>
&gt;&gt;&gt;&gt; &gt; than 1 part, all parts except for the last one need t=
o be &gt; 5M. Which<br>
&gt;&gt;&gt;&gt; &gt; means that for uploads that are smaller than 5M there=
 should be zero<br>
&gt;&gt;&gt;&gt; &gt; or one parts.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; On Mon, Dec 2, 2013 at 12:54 PM, Dominik Mostowiec<br=
>
&gt;&gt;&gt;&gt; &gt; &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dom=
inikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; &gt;&gt; You&#39;re right.<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; S3 api doc:<br>
&gt;&gt;&gt;&gt; &gt;&gt; <a href=3D"http://docs.aws.amazon.com/AmazonS3/la=
test/API/mpUploadComplete.html" target=3D"_blank">http://docs.aws.amazon.co=
m/AmazonS3/latest/API/mpUploadComplete.html</a><br>
&gt;&gt;&gt;&gt; &gt;&gt; &quot;Err:EntityTooSmall<br>
&gt;&gt;&gt;&gt; &gt;&gt; Your proposed upload is smaller than the minimum =
allowed object size.<br>
&gt;&gt;&gt;&gt; &gt;&gt; Each part must be at least 5 MB in size, except t=
he last part.&quot;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; Thanks.<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; This error should be triggered from radosgw also.=
<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; &gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; 2013/12/2 Yehuda Sadeh &lt;<a href=3D"mailto:yehu=
da-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt; Looks like it. There should be a guard agains=
t it (mulitpart upload<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt; minimum is 5M).<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt; On Mon, Dec 2, 2013 at 12:32 PM, Dominik Most=
owiec<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:dominikmostowiec@gmail.=
com">dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; Yes, this is probably upload empty file.<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; This is the problem?<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; 2013/12/2 Yehuda Sadeh &lt;<a href=3D"mai=
lto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; By any chance are you uploading empty=
 objects through the multipart<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; upload api?<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; On Mon, Dec 2, 2013 at 12:08 PM, Domi=
nik Mostowiec<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:dominikmostowie=
c@gmail.com">dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Another file with the same proble=
ms:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556687 7f7891=
fd3700 =A01 =3D=3D=3D=3D=3D=3D starting new<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; request<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; req=3D0x25406d0 =3D=3D=3D=3D=3D<b=
r>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556739 7f7891=
fd3700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 1314:0.000052::::initializing<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556789 7f7891=
fd3700 10 s-&gt;object=3Dfiles/192.txt<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; s-&gt;bucket=3Dtestbucket<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556799 7f7891=
fd3700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 1314:0.000112:s3:POST<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt::gettin=
g op<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556804 7f7891=
fd3700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 1314:0.000118:s3:POST<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complet=
e_multipart:authorizing<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.560013 7f7891=
fd3700 10 get_canon_resource():<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; dest=3D/testbucket/files/192.txt?=
uploadId=3Di92xi2olzDtFAeLXlfU2PFP9CDU87BC<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.560027 7f7891=
fd3700 10 auth_hdr:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; POST<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; application/xml<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Sun, 01 Dec 2013 10:37:10 GMT<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt?uploadI=
d=3Di92xi2olzDtFAeLXlfU2PFP9CDU87BC<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.560085 7f7891=
fd3700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 1314:0.003399:s3:POST<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complet=
e_multipart:reading permissions<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562356 7f7891=
fd3700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 1314:0.005670:s3:POST<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complet=
e_multipart:verifying op<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; permissions<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562373 7f7891=
fd3700 =A05 Searching permissions<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; for<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; uid=3D0 mask=3D2<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562377 7f7891=
fd3700 =A05 Found permission: 15<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562378 7f7891=
fd3700 10 =A0uid=3D0 requested perm<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; (type)=3D2, policy perm=3D2, user=
_perm_mask=3D2, acl perm=3D2<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562381 7f7891=
fd3700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 1314:0.005695:s3:POST<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complet=
e_multipart:verifying op params<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562384 7f7891=
fd3700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 1314:0.005698:s3:POST<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complet=
e_multipart:executing<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.565461 7f7891=
fd3700 10 calculated etag:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; d41d8cd98f00b204e9800998ecf8427e-=
0<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.566718 7f7891=
fd3700 10 can&#39;t clone object<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; testbucket:files/192.txt to shado=
w object, tag/shadow_obj haven&#39;t<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; been<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; set<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.566777 7f7891=
fd3700 =A00 setting object<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; tag=3D_leyAzxCw7YxpKv8P3v3QGwcsw_=
_9VmP<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.678973 7f7891=
fd3700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 1314:0.122286:s3:POST<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complet=
e_multipart:http status=3D200<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.679192 7f7891=
fd3700 =A01 =3D=3D=3D=3D=3D=3D req done<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; req=3D0x25406d0 http_status=3D200=
 =3D=3D=3D=3D=3D=3D<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Yes, I can read oryginal object.<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2013/12/2 Yehuda Sadeh &lt;<a hre=
f=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; That&#39;s unknown bug. I hav=
e a guess as to how the original object<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; was<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; created. Can you read the ori=
ginal object, but only copy fails?<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; On Dec 2, 2013 4:53 AM, &quot=
;Dominik Mostowiec&quot;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:dominik=
mostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I found that issue is rel=
ated with &quot;ETag: ....-0&quot; (ends -0)<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is known bug ?<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2013/12/2 Dominik Mostowi=
ec &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmostowiec@gmail=
.com</a>&gt;:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Hi,<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; I have strange probl=
em.<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Obj copy (0 size) ki=
lling radosgw.<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Head for this file:<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Content-Type: applic=
ation/octet-stream<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Server: Apache/2.2.2=
2 (Ubuntu)<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; ETag: &quot;d41d8cd9=
8f00b204e9800998ecf8427e-0&quot;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Last-Modified: 2013-=
12-01T10:37:15Z<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; rgw log.<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196651 7f5308ff1700 =A01 =3D=3D=3D=3D=3D=3D starting new<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; request<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; req=3D0x2be6fa0 =3D=
=3D=3D=3D=3D<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196709 7f5308ff1700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 237:0.000058::::init=
ializing<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196752 7f5308ff1700 10 meta&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; HTTP_X_AMZ_ACL=3Dpub=
lic-read<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196760 7f5308ff1700 10 meta&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; HTTP_X_AMZ_COPY_SOUR=
CE=3D/testbucket/testfile.xml<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196766 7f5308ff1700 10 meta&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; HTTP_X_AMZ_METADATA_=
DIRECTIVE=3DCOPY<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196771 7f5308ff1700 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-acl:public-rea=
d<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196772 7f5308ff1700 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-copy-source:/t=
estbucket/testfile.xml<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196773 7f5308ff1700 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-metadata-direc=
tive:COPY<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196786 7f5308ff1700 10<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; s-&gt;object=3D/test=
bucket/new_testfile.ini s-&gt;bucket=3Dtestbucket<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196792 7f5308ff1700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 237:0.000141:s3:PUT<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_test=
file.ini::getting op<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
196797 7f5308ff1700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 237:0.000146:s3:PUT<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_test=
file.ini:copy_obj:authorizing<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
200648 7f5308ff1700 10<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; get_canon_resource()=
:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; dest=3D/testbucket/n=
ew_testfile.ini<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
200661 7f5308ff1700 10 auth_hdr:<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; PUT<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 1B2M2Y8AsgTpgAmY7PhC=
fg=3D=3D<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; application/octet-st=
ream<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Mon, 02 Dec 2013 07:=
18:55 GMT<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-acl:public-rea=
d<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-copy-source:/t=
estbucket/testfile.xml<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-metadata-direc=
tive:COPY<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_test=
file.ini<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
200717 7f5308ff1700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 237:0.004066:s3:PUT<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_test=
file.ini:copy_obj:reading permissions<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
203330 7f5308ff1700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 237:0.006679:s3:PUT<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_test=
file.ini:copy_obj:verifying op permissions<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207627 7f5308ff1700 10 manifest: total_size<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; =3D 0<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207649 7f5308ff1700 =A05 Searching<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; permissions for<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; uid=3D0 mask=3D1<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207652 7f5308ff1700 =A05 Found permission: 15<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207654 7f5308ff1700 10 =A0uid=3D0 requested<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; perm<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; (type)=3D1, policy p=
erm=3D1, user_perm_mask=3D15, acl perm=3D1<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207669 7f5308ff1700 =A05 Searching<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; permissions for<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; uid=3D0 mask=3D2<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207670 7f5308ff1700 =A05 Found permission: 15<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207671 7f5308ff1700 10 =A0uid=3D0 requested<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; perm<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; (type)=3D2, policy p=
erm=3D2, user_perm_mask=3D15, acl perm=3D2<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207681 7f5308ff1700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 237:0.011030:s3:PUT<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_test=
file.ini:copy_obj:verifying op params<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207686 7f5308ff1700 =A02 req<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 237:0.011035:s3:PUT<=
br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_test=
file.ini:copy_obj:executing<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207699 7f5308ff1700 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-acl:public-rea=
d<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207704 7f5308ff1700 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-copy-source:/t=
estbucket/testfile.xml<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207709 7f5308ff1700 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-metadata-direc=
tive:COPY<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
207759 7f5308ff1700 =A05 Copy object<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; testbucket(@.rgw.buc=
kets[406250.1]):testfile.ini =3D&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; testbucket(@.rgw.buc=
kets[406250.1]):new_testfile.ini<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.=
208903 7f5308ff1700 -1 *** Caught signal<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; (Segmentation fault)=
 **<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; =A0in thread 7f5308f=
f1700<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Regards<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Dominik<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Pozdrawiam<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; _________________________=
______________________<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ceph-users mailing list<b=
r>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.c=
eph.com/listinfo.cgi/ceph-users-ceph.com" target=3D"_blank">http://lists.ce=
ph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Pozdrawiam<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; Pozdrawiam<br>
&gt;&gt;&gt;&gt; &gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; --<br>
&gt;&gt;&gt;&gt; &gt;&gt; Pozdrawiam<br>
&gt;&gt;&gt;&gt; &gt;&gt; Dominik<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Pozdrawiam<br>
&gt;&gt;&gt; Dominik<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Pozdrawiam<br>
&gt; Dominik<br>
</blockquote></div>

--f46d044481a520f6b804ec9b588a--

--===============1834890696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1834890696==--
