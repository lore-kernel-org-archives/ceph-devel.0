From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: radosgw Segmentation fault on obj copy
Date: Tue, 3 Dec 2013 03:13:33 +0100
Message-ID: <CAMNMNTyL450z=uTHMs9Uo=Gf8EOLikcyn0i7_jMRX63KwHZfEA@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1713191317=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABBk=J9a3M6yAZj40+XZKLfmoHj7xsYj3GTfs34Be8twSb19UQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1713191317==
Content-Type: multipart/alternative; boundary=089e01175e4dedd57a04ec97d7c1

--089e01175e4dedd57a04ec97d7c1
Content-Type: text/plain; charset=ISO-8859-1

0.56.7
On Dec 2, 2013 11:30 PM, "Yehuda Sadeh" <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> I'm having trouble reproducing the issue. What version are you using?
>
> Thanks,
> Yehuda
>
> On Mon, Dec 2, 2013 at 2:16 PM, Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> > Actually, I read that differently. It only says that if there's more
> > than 1 part, all parts except for the last one need to be > 5M. Which
> > means that for uploads that are smaller than 5M there should be zero
> > or one parts.
> >
> > On Mon, Dec 2, 2013 at 12:54 PM, Dominik Mostowiec
> > <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> You're right.
> >>
> >> S3 api doc:
> http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadComplete.html
> >> "Err:EntityTooSmall
> >> Your proposed upload is smaller than the minimum allowed object size.
> >> Each part must be at least 5 MB in size, except the last part."
> >>
> >> Thanks.
> >>
> >> This error should be triggered from radosgw also.
> >>
> >> --
> >> Regards
> >> Dominik
> >>
> >> 2013/12/2 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >>> Looks like it. There should be a guard against it (mulitpart upload
> >>> minimum is 5M).
> >>>
> >>> On Mon, Dec 2, 2013 at 12:32 PM, Dominik Mostowiec
> >>> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>> Yes, this is probably upload empty file.
> >>>> This is the problem?
> >>>>
> >>>> --
> >>>> Regards
> >>>> Dominik
> >>>>
> >>>>
> >>>> 2013/12/2 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >>>>> By any chance are you uploading empty objects through the multipart
> upload api?
> >>>>>
> >>>>> On Mon, Dec 2, 2013 at 12:08 PM, Dominik Mostowiec
> >>>>> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>>>> Hi,
> >>>>>> Another file with the same problems:
> >>>>>>
> >>>>>> 2013-12-01 11:37:15.556687 7f7891fd3700  1 ====== starting new
> request
> >>>>>> req=0x25406d0 =====
> >>>>>> 2013-12-01 11:37:15.556739 7f7891fd3700  2 req
> 1314:0.000052::::initializing
> >>>>>> 2013-12-01 11:37:15.556789 7f7891fd3700 10 s->object=files/192.txt
> >>>>>> s->bucket=testbucket
> >>>>>> 2013-12-01 11:37:15.556799 7f7891fd3700  2 req 1314:0.000112:s3:POST
> >>>>>> /testbucket/files/192.txt::getting op
> >>>>>> 2013-12-01 11:37:15.556804 7f7891fd3700  2 req 1314:0.000118:s3:POST
> >>>>>> /testbucket/files/192.txt:complete_multipart:authorizing
> >>>>>> 2013-12-01 11:37:15.560013 7f7891fd3700 10 get_canon_resource():
> >>>>>>
> dest=/testbucket/files/192.txt?uploadId=i92xi2olzDtFAeLXlfU2PFP9CDU87BC
> >>>>>> 2013-12-01 11:37:15.560027 7f7891fd3700 10 auth_hdr:
> >>>>>> POST
> >>>>>>
> >>>>>> application/xml
> >>>>>> Sun, 01 Dec 2013 10:37:10 GMT
> >>>>>> /testbucket/files/192.txt?uploadId=i92xi2olzDtFAeLXlfU2PFP9CDU87BC
> >>>>>> 2013-12-01 11:37:15.560085 7f7891fd3700  2 req 1314:0.003399:s3:POST
> >>>>>> /testbucket/files/192.txt:complete_multipart:reading permissions
> >>>>>> 2013-12-01 11:37:15.562356 7f7891fd3700  2 req 1314:0.005670:s3:POST
> >>>>>> /testbucket/files/192.txt:complete_multipart:verifying op
> permissions
> >>>>>> 2013-12-01 11:37:15.562373 7f7891fd3700  5 Searching permissions for
> >>>>>> uid=0 mask=2
> >>>>>> 2013-12-01 11:37:15.562377 7f7891fd3700  5 Found permission: 15
> >>>>>> 2013-12-01 11:37:15.562378 7f7891fd3700 10  uid=0 requested perm
> >>>>>> (type)=2, policy perm=2, user_perm_mask=2, acl perm=2
> >>>>>> 2013-12-01 11:37:15.562381 7f7891fd3700  2 req 1314:0.005695:s3:POST
> >>>>>> /testbucket/files/192.txt:complete_multipart:verifying op params
> >>>>>> 2013-12-01 11:37:15.562384 7f7891fd3700  2 req 1314:0.005698:s3:POST
> >>>>>> /testbucket/files/192.txt:complete_multipart:executing
> >>>>>> 2013-12-01 11:37:15.565461 7f7891fd3700 10 calculated etag:
> >>>>>> d41d8cd98f00b204e9800998ecf8427e-0
> >>>>>> 2013-12-01 11:37:15.566718 7f7891fd3700 10 can't clone object
> >>>>>> testbucket:files/192.txt to shadow object, tag/shadow_obj haven't
> been
> >>>>>> set
> >>>>>> 2013-12-01 11:37:15.566777 7f7891fd3700  0 setting object
> >>>>>> tag=_leyAzxCw7YxpKv8P3v3QGwcsw__9VmP
> >>>>>> 2013-12-01 11:37:15.678973 7f7891fd3700  2 req 1314:0.122286:s3:POST
> >>>>>> /testbucket/files/192.txt:complete_multipart:http status=200
> >>>>>> 2013-12-01 11:37:15.679192 7f7891fd3700  1 ====== req done
> >>>>>> req=0x25406d0 http_status=200 ======
> >>>>>>
> >>>>>> Yes, I can read oryginal object.
> >>>>>>
> >>>>>> --
> >>>>>> Regards
> >>>>>> Dominik
> >>>>>>
> >>>>>> 2013/12/2 Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >>>>>>> That's unknown bug. I have a guess as to how the original object
> was
> >>>>>>> created. Can you read the original object, but only copy fails?
> >>>>>>>
> >>>>>>> On Dec 2, 2013 4:53 AM, "Dominik Mostowiec" <
> dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>>>>> wrote:
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>> I found that issue is related with "ETag: ....-0" (ends -0)
> >>>>>>>> This is known bug ?
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> Regards
> >>>>>>>> Dominik
> >>>>>>>>
> >>>>>>>> 2013/12/2 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>>>>>>> > Hi,
> >>>>>>>> > I have strange problem.
> >>>>>>>> > Obj copy (0 size) killing radosgw.
> >>>>>>>> >
> >>>>>>>> > Head for this file:
> >>>>>>>> > Content-Type: application/octet-stream
> >>>>>>>> > Server: Apache/2.2.22 (Ubuntu)
> >>>>>>>> > ETag: "d41d8cd98f00b204e9800998ecf8427e-0"
> >>>>>>>> > Last-Modified: 2013-12-01T10:37:15Z
> >>>>>>>> >
> >>>>>>>> > rgw log.
> >>>>>>>> > 2013-12-02 08:18:59.196651 7f5308ff1700  1 ====== starting new
> request
> >>>>>>>> > req=0x2be6fa0 =====
> >>>>>>>> > 2013-12-02 08:18:59.196709 7f5308ff1700  2 req
> >>>>>>>> > 237:0.000058::::initializing
> >>>>>>>> > 2013-12-02 08:18:59.196752 7f5308ff1700 10 meta>>
> >>>>>>>> > HTTP_X_AMZ_ACL=public-read
> >>>>>>>> > 2013-12-02 08:18:59.196760 7f5308ff1700 10 meta>>
> >>>>>>>> > HTTP_X_AMZ_COPY_SOURCE=/testbucket/testfile.xml
> >>>>>>>> > 2013-12-02 08:18:59.196766 7f5308ff1700 10 meta>>
> >>>>>>>> > HTTP_X_AMZ_METADATA_DIRECTIVE=COPY
> >>>>>>>> > 2013-12-02 08:18:59.196771 7f5308ff1700 10 x>>
> x-amz-acl:public-read
> >>>>>>>> > 2013-12-02 08:18:59.196772 7f5308ff1700 10 x>>
> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
> >>>>>>>> > 2013-12-02 08:18:59.196773 7f5308ff1700 10 x>>
> >>>>>>>> > x-amz-metadata-directive:COPY
> >>>>>>>> > 2013-12-02 08:18:59.196786 7f5308ff1700 10
> >>>>>>>> > s->object=/testbucket/new_testfile.ini s->bucket=testbucket
> >>>>>>>> > 2013-12-02 08:18:59.196792 7f5308ff1700  2 req
> 237:0.000141:s3:PUT
> >>>>>>>> > /testbucket/new_testfile.ini::getting op
> >>>>>>>> > 2013-12-02 08:18:59.196797 7f5308ff1700  2 req
> 237:0.000146:s3:PUT
> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:authorizing
> >>>>>>>> > 2013-12-02 08:18:59.200648 7f5308ff1700 10 get_canon_resource():
> >>>>>>>> > dest=/testbucket/new_testfile.ini
> >>>>>>>> > 2013-12-02 08:18:59.200661 7f5308ff1700 10 auth_hdr:
> >>>>>>>> > PUT
> >>>>>>>> > 1B2M2Y8AsgTpgAmY7PhCfg==
> >>>>>>>> > application/octet-stream
> >>>>>>>> > Mon, 02 Dec 2013 07:18:55 GMT
> >>>>>>>> > x-amz-acl:public-read
> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
> >>>>>>>> > x-amz-metadata-directive:COPY
> >>>>>>>> > /testbucket/new_testfile.ini
> >>>>>>>> > 2013-12-02 08:18:59.200717 7f5308ff1700  2 req
> 237:0.004066:s3:PUT
> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:reading permissions
> >>>>>>>> > 2013-12-02 08:18:59.203330 7f5308ff1700  2 req
> 237:0.006679:s3:PUT
> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:verifying op permissions
> >>>>>>>> > 2013-12-02 08:18:59.207627 7f5308ff1700 10 manifest: total_size
> = 0
> >>>>>>>> > 2013-12-02 08:18:59.207649 7f5308ff1700  5 Searching
> permissions for
> >>>>>>>> > uid=0 mask=1
> >>>>>>>> > 2013-12-02 08:18:59.207652 7f5308ff1700  5 Found permission: 15
> >>>>>>>> > 2013-12-02 08:18:59.207654 7f5308ff1700 10  uid=0 requested perm
> >>>>>>>> > (type)=1, policy perm=1, user_perm_mask=15, acl perm=1
> >>>>>>>> > 2013-12-02 08:18:59.207669 7f5308ff1700  5 Searching
> permissions for
> >>>>>>>> > uid=0 mask=2
> >>>>>>>> > 2013-12-02 08:18:59.207670 7f5308ff1700  5 Found permission: 15
> >>>>>>>> > 2013-12-02 08:18:59.207671 7f5308ff1700 10  uid=0 requested perm
> >>>>>>>> > (type)=2, policy perm=2, user_perm_mask=15, acl perm=2
> >>>>>>>> > 2013-12-02 08:18:59.207681 7f5308ff1700  2 req
> 237:0.011030:s3:PUT
> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:verifying op params
> >>>>>>>> > 2013-12-02 08:18:59.207686 7f5308ff1700  2 req
> 237:0.011035:s3:PUT
> >>>>>>>> > /testbucket/new_testfile.ini:copy_obj:executing
> >>>>>>>> > 2013-12-02 08:18:59.207699 7f5308ff1700 10 x>>
> x-amz-acl:public-read
> >>>>>>>> > 2013-12-02 08:18:59.207704 7f5308ff1700 10 x>>
> >>>>>>>> > x-amz-copy-source:/testbucket/testfile.xml
> >>>>>>>> > 2013-12-02 08:18:59.207709 7f5308ff1700 10 x>>
> >>>>>>>> > x-amz-metadata-directive:COPY
> >>>>>>>> > 2013-12-02 08:18:59.207759 7f5308ff1700  5 Copy object
> >>>>>>>> > testbucket(@.rgw.buckets[406250.1]):testfile.ini =>
> >>>>>>>> > testbucket(@.rgw.buckets[406250.1]):new_testfile.ini
> >>>>>>>> > 2013-12-02 08:18:59.208903 7f5308ff1700 -1 *** Caught signal
> >>>>>>>> > (Segmentation fault) **
> >>>>>>>> >  in thread 7f5308ff1700
> >>>>>>>> >
> >>>>>>>> >
> >>>>>>>> > --
> >>>>>>>> > Regards
> >>>>>>>> > Dominik
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> Pozdrawiam
> >>>>>>>> Dominik
> >>>>>>>> _______________________________________________
> >>>>>>>> ceph-users mailing list
> >>>>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Pozdrawiam
> >>>>>> Dominik
> >>>>
> >>>>
> >>>>
> >>>> --
> >>>> Pozdrawiam
> >>>> Dominik
> >>
> >>
> >>
> >> --
> >> Pozdrawiam
> >> Dominik
>

--089e01175e4dedd57a04ec97d7c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">0.56.7</p>
<div class=3D"gmail_quote">On Dec 2, 2013 11:30 PM, &quot;Yehuda Sadeh&quot=
; &lt;<a href=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; wrot=
e:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
I&#39;m having trouble reproducing the issue. What version are you using?<b=
r>
<br>
Thanks,<br>
Yehuda<br>
<br>
On Mon, Dec 2, 2013 at 2:16 PM, Yehuda Sadeh &lt;<a href=3D"mailto:yehuda@i=
nktank.com">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>
&gt; Actually, I read that differently. It only says that if there&#39;s mo=
re<br>
&gt; than 1 part, all parts except for the last one need to be &gt; 5M. Whi=
ch<br>
&gt; means that for uploads that are smaller than 5M there should be zero<b=
r>
&gt; or one parts.<br>
&gt;<br>
&gt; On Mon, Dec 2, 2013 at 12:54 PM, Dominik Mostowiec<br>
&gt; &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmostowiec@gma=
il.com</a>&gt; wrote:<br>
&gt;&gt; You&#39;re right.<br>
&gt;&gt;<br>
&gt;&gt; S3 api doc: <a href=3D"http://docs.aws.amazon.com/AmazonS3/latest/=
API/mpUploadComplete.html" target=3D"_blank">http://docs.aws.amazon.com/Ama=
zonS3/latest/API/mpUploadComplete.html</a><br>
&gt;&gt; &quot;Err:EntityTooSmall<br>
&gt;&gt; Your proposed upload is smaller than the minimum allowed object si=
ze.<br>
&gt;&gt; Each part must be at least 5 MB in size, except the last part.&quo=
t;<br>
&gt;&gt;<br>
&gt;&gt; Thanks.<br>
&gt;&gt;<br>
&gt;&gt; This error should be triggered from radosgw also.<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Regards<br>
&gt;&gt; Dominik<br>
&gt;&gt;<br>
&gt;&gt; 2013/12/2 Yehuda Sadeh &lt;<a href=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">y=
ehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;:<br>
&gt;&gt;&gt; Looks like it. There should be a guard against it (mulitpart u=
pload<br>
&gt;&gt;&gt; minimum is 5M).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Mon, Dec 2, 2013 at 12:32 PM, Dominik Mostowiec<br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmosto=
wiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt; Yes, this is probably upload empty file.<br>
&gt;&gt;&gt;&gt; This is the problem?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 2013/12/2 Yehuda Sadeh &lt;<a href=3D"mailto:yehuda@inktan=
k.com">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;:<br>
&gt;&gt;&gt;&gt;&gt; By any chance are you uploading empty objects through =
the multipart upload api?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Mon, Dec 2, 2013 at 12:08 PM, Dominik Mostowiec<br>
&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">domi=
nikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;&gt;&gt; Another file with the same problems:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556687 7f7891fd3700 =A01 =3D=
=3D=3D=3D=3D=3D starting new request<br>
&gt;&gt;&gt;&gt;&gt;&gt; req=3D0x25406d0 =3D=3D=3D=3D=3D<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556739 7f7891fd3700 =A02 req 1=
314:0.000052::::initializing<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556789 7f7891fd3700 10 s-&gt;o=
bject=3Dfiles/192.txt<br>
&gt;&gt;&gt;&gt;&gt;&gt; s-&gt;bucket=3Dtestbucket<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556799 7f7891fd3700 =A02 req 1=
314:0.000112:s3:POST<br>
&gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt::getting op<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.556804 7f7891fd3700 =A02 req 1=
314:0.000118:s3:POST<br>
&gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complete_multipart:autho=
rizing<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.560013 7f7891fd3700 10 get_can=
on_resource():<br>
&gt;&gt;&gt;&gt;&gt;&gt; dest=3D/testbucket/files/192.txt?uploadId=3Di92xi2=
olzDtFAeLXlfU2PFP9CDU87BC<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.560027 7f7891fd3700 10 auth_hd=
r:<br>
&gt;&gt;&gt;&gt;&gt;&gt; POST<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; application/xml<br>
&gt;&gt;&gt;&gt;&gt;&gt; Sun, 01 Dec 2013 10:37:10 GMT<br>
&gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt?uploadId=3Di92xi2olzDtFA=
eLXlfU2PFP9CDU87BC<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.560085 7f7891fd3700 =A02 req 1=
314:0.003399:s3:POST<br>
&gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complete_multipart:readi=
ng permissions<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562356 7f7891fd3700 =A02 req 1=
314:0.005670:s3:POST<br>
&gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complete_multipart:verif=
ying op permissions<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562373 7f7891fd3700 =A05 Searc=
hing permissions for<br>
&gt;&gt;&gt;&gt;&gt;&gt; uid=3D0 mask=3D2<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562377 7f7891fd3700 =A05 Found=
 permission: 15<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562378 7f7891fd3700 10 =A0uid=
=3D0 requested perm<br>
&gt;&gt;&gt;&gt;&gt;&gt; (type)=3D2, policy perm=3D2, user_perm_mask=3D2, a=
cl perm=3D2<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562381 7f7891fd3700 =A02 req 1=
314:0.005695:s3:POST<br>
&gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complete_multipart:verif=
ying op params<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.562384 7f7891fd3700 =A02 req 1=
314:0.005698:s3:POST<br>
&gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complete_multipart:execu=
ting<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.565461 7f7891fd3700 10 calcula=
ted etag:<br>
&gt;&gt;&gt;&gt;&gt;&gt; d41d8cd98f00b204e9800998ecf8427e-0<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.566718 7f7891fd3700 10 can&#39=
;t clone object<br>
&gt;&gt;&gt;&gt;&gt;&gt; testbucket:files/192.txt to shadow object, tag/sha=
dow_obj haven&#39;t been<br>
&gt;&gt;&gt;&gt;&gt;&gt; set<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.566777 7f7891fd3700 =A00 setti=
ng object<br>
&gt;&gt;&gt;&gt;&gt;&gt; tag=3D_leyAzxCw7YxpKv8P3v3QGwcsw__9VmP<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.678973 7f7891fd3700 =A02 req 1=
314:0.122286:s3:POST<br>
&gt;&gt;&gt;&gt;&gt;&gt; /testbucket/files/192.txt:complete_multipart:http =
status=3D200<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013-12-01 11:37:15.679192 7f7891fd3700 =A01 =3D=
=3D=3D=3D=3D=3D req done<br>
&gt;&gt;&gt;&gt;&gt;&gt; req=3D0x25406d0 http_status=3D200 =3D=3D=3D=3D=3D=
=3D<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Yes, I can read oryginal object.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2013/12/2 Yehuda Sadeh &lt;<a href=3D"mailto:yehud=
a@inktank.com">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; That&#39;s unknown bug. I have a guess as to h=
ow the original object was<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; created. Can you read the original object, but=
 only copy fails?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Dec 2, 2013 4:53 AM, &quot;Dominik Mostowie=
c&quot; &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmostowiec@=
gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I found that issue is related with &quot;E=
Tag: ....-0&quot; (ends -0)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is known bug ?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 2013/12/2 Dominik Mostowiec &lt;<a href=3D=
"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Hi,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; I have strange problem.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Obj copy (0 size) killing radosgw.<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Head for this file:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Content-Type: application/octet-strea=
m<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Server: Apache/2.2.22 (Ubuntu)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; ETag: &quot;d41d8cd98f00b204e9800998e=
cf8427e-0&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Last-Modified: 2013-12-01T10:37:15Z<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; rgw log.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196651 7f5308ff17=
00 =A01 =3D=3D=3D=3D=3D=3D starting new request<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; req=3D0x2be6fa0 =3D=3D=3D=3D=3D<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196709 7f5308ff17=
00 =A02 req<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 237:0.000058::::initializing<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196752 7f5308ff17=
00 10 meta&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; HTTP_X_AMZ_ACL=3Dpublic-read<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196760 7f5308ff17=
00 10 meta&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; HTTP_X_AMZ_COPY_SOURCE=3D/testbucket/=
testfile.xml<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196766 7f5308ff17=
00 10 meta&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; HTTP_X_AMZ_METADATA_DIRECTIVE=3DCOPY<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196771 7f5308ff17=
00 10 x&gt;&gt; x-amz-acl:public-read<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196772 7f5308ff17=
00 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-copy-source:/testbucket/testfil=
e.xml<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196773 7f5308ff17=
00 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-metadata-directive:COPY<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196786 7f5308ff17=
00 10<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; s-&gt;object=3D/testbucket/new_testfi=
le.ini s-&gt;bucket=3Dtestbucket<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196792 7f5308ff17=
00 =A02 req 237:0.000141:s3:PUT<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_testfile.ini::getting=
 op<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.196797 7f5308ff17=
00 =A02 req 237:0.000146:s3:PUT<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_testfile.ini:copy_obj=
:authorizing<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.200648 7f5308ff17=
00 10 get_canon_resource():<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; dest=3D/testbucket/new_testfile.ini<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.200661 7f5308ff17=
00 10 auth_hdr:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; PUT<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 1B2M2Y8AsgTpgAmY7PhCfg=3D=3D<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; application/octet-stream<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Mon, 02 Dec 2013 07:18:55 GMT<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-acl:public-read<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-copy-source:/testbucket/testfil=
e.xml<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-metadata-directive:COPY<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_testfile.ini<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.200717 7f5308ff17=
00 =A02 req 237:0.004066:s3:PUT<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_testfile.ini:copy_obj=
:reading permissions<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.203330 7f5308ff17=
00 =A02 req 237:0.006679:s3:PUT<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_testfile.ini:copy_obj=
:verifying op permissions<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207627 7f5308ff17=
00 10 manifest: total_size =3D 0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207649 7f5308ff17=
00 =A05 Searching permissions for<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; uid=3D0 mask=3D1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207652 7f5308ff17=
00 =A05 Found permission: 15<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207654 7f5308ff17=
00 10 =A0uid=3D0 requested perm<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; (type)=3D1, policy perm=3D1, user_per=
m_mask=3D15, acl perm=3D1<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207669 7f5308ff17=
00 =A05 Searching permissions for<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; uid=3D0 mask=3D2<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207670 7f5308ff17=
00 =A05 Found permission: 15<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207671 7f5308ff17=
00 10 =A0uid=3D0 requested perm<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; (type)=3D2, policy perm=3D2, user_per=
m_mask=3D15, acl perm=3D2<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207681 7f5308ff17=
00 =A02 req 237:0.011030:s3:PUT<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_testfile.ini:copy_obj=
:verifying op params<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207686 7f5308ff17=
00 =A02 req 237:0.011035:s3:PUT<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; /testbucket/new_testfile.ini:copy_obj=
:executing<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207699 7f5308ff17=
00 10 x&gt;&gt; x-amz-acl:public-read<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207704 7f5308ff17=
00 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-copy-source:/testbucket/testfil=
e.xml<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207709 7f5308ff17=
00 10 x&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; x-amz-metadata-directive:COPY<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.207759 7f5308ff17=
00 =A05 Copy object<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; testbucket(@.rgw.buckets[406250.1]):t=
estfile.ini =3D&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; testbucket(@.rgw.buckets[406250.1]):n=
ew_testfile.ini<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; 2013-12-02 08:18:59.208903 7f5308ff17=
00 -1 *** Caught signal<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; (Segmentation fault) **<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; =A0in thread 7f5308ff1700<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Regards<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Dominik<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Pozdrawiam<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; __________________________________________=
_____<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ceph-users mailing list<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFLNfb0M+mGrxg@public.gmane.org=
m">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://lists.ceph.com/listinfo.=
cgi/ceph-users-ceph.com" target=3D"_blank">http://lists.ceph.com/listinfo.c=
gi/ceph-users-ceph.com</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt;&gt; Pozdrawiam<br>
&gt;&gt;&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; Pozdrawiam<br>
&gt;&gt;&gt;&gt; Dominik<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Pozdrawiam<br>
&gt;&gt; Dominik<br>
</blockquote></div>

--089e01175e4dedd57a04ec97d7c1--

--===============1713191317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1713191317==--
