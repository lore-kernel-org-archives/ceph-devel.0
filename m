From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: radosgw Segmentation fault on obj copy
Date: Mon, 2 Dec 2013 19:07:58 +0100
Message-ID: <CAMNMNTwZ_VtC8huh293-upnZXLrfc40RUDJG2tia5knF4ZxS4w@mail.gmail.com>
References: <CAMNMNTzEVkom0cBe_jepaE95hzVGys+8y+-PA+2dSsTqNwg=tA@mail.gmail.com>
	<CAMNMNTzx_CHmYRXXE-KhbEwNZqLAAcTBp-5SZks7UiQ+OS1XqA@mail.gmail.com>
	<CABBk=J-HAPxi4eg0AW_vD0T+QoqRzBMchpovM9s+EhzzC2ZZmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1205501141=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABBk=J-HAPxi4eg0AW_vD0T+QoqRzBMchpovM9s+EhzzC2ZZmg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1205501141==
Content-Type: multipart/alternative; boundary=089e015376b65c7e0104ec910f4a

--089e015376b65c7e0104ec910f4a
Content-Type: text/plain; charset=ISO-8859-1

Yes I can read it.  Oryginal object is 0 size.

Regards
Dominik
On Dec 2, 2013 6:14 PM, "Yehuda Sadeh" <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> That's unknown bug. I have a guess as to how the original object was
> created. Can you read the original object, but only copy fails?
> On Dec 2, 2013 4:53 AM, "Dominik Mostowiec" <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
>
>> Hi,
>> I found that issue is related with "ETag: ....-0" (ends -0)
>> This is known bug ?
>>
>> --
>> Regards
>> Dominik
>>
>> 2013/12/2 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> > Hi,
>> > I have strange problem.
>> > Obj copy (0 size) killing radosgw.
>> >
>> > Head for this file:
>> > Content-Type: application/octet-stream
>> > Server: Apache/2.2.22 (Ubuntu)
>> > ETag: "d41d8cd98f00b204e9800998ecf8427e-0"
>> > Last-Modified: 2013-12-01T10:37:15Z
>> >
>> > rgw log.
>> > 2013-12-02 08:18:59.196651 7f5308ff1700  1 ====== starting new request
>> > req=0x2be6fa0 =====
>> > 2013-12-02 08:18:59.196709 7f5308ff1700  2 req
>> 237:0.000058::::initializing
>> > 2013-12-02 08:18:59.196752 7f5308ff1700 10 meta>>
>> HTTP_X_AMZ_ACL=public-read
>> > 2013-12-02 08:18:59.196760 7f5308ff1700 10 meta>>
>> > HTTP_X_AMZ_COPY_SOURCE=/testbucket/testfile.xml
>> > 2013-12-02 08:18:59.196766 7f5308ff1700 10 meta>>
>> > HTTP_X_AMZ_METADATA_DIRECTIVE=COPY
>> > 2013-12-02 08:18:59.196771 7f5308ff1700 10 x>> x-amz-acl:public-read
>> > 2013-12-02 08:18:59.196772 7f5308ff1700 10 x>>
>> > x-amz-copy-source:/testbucket/testfile.xml
>> > 2013-12-02 08:18:59.196773 7f5308ff1700 10 x>>
>> x-amz-metadata-directive:COPY
>> > 2013-12-02 08:18:59.196786 7f5308ff1700 10
>> > s->object=/testbucket/new_testfile.ini s->bucket=testbucket
>> > 2013-12-02 08:18:59.196792 7f5308ff1700  2 req 237:0.000141:s3:PUT
>> > /testbucket/new_testfile.ini::getting op
>> > 2013-12-02 08:18:59.196797 7f5308ff1700  2 req 237:0.000146:s3:PUT
>> > /testbucket/new_testfile.ini:copy_obj:authorizing
>> > 2013-12-02 08:18:59.200648 7f5308ff1700 10 get_canon_resource():
>> > dest=/testbucket/new_testfile.ini
>> > 2013-12-02 08:18:59.200661 7f5308ff1700 10 auth_hdr:
>> > PUT
>> > 1B2M2Y8AsgTpgAmY7PhCfg==
>> > application/octet-stream
>> > Mon, 02 Dec 2013 07:18:55 GMT
>> > x-amz-acl:public-read
>> > x-amz-copy-source:/testbucket/testfile.xml
>> > x-amz-metadata-directive:COPY
>> > /testbucket/new_testfile.ini
>> > 2013-12-02 08:18:59.200717 7f5308ff1700  2 req 237:0.004066:s3:PUT
>> > /testbucket/new_testfile.ini:copy_obj:reading permissions
>> > 2013-12-02 08:18:59.203330 7f5308ff1700  2 req 237:0.006679:s3:PUT
>> > /testbucket/new_testfile.ini:copy_obj:verifying op permissions
>> > 2013-12-02 08:18:59.207627 7f5308ff1700 10 manifest: total_size = 0
>> > 2013-12-02 08:18:59.207649 7f5308ff1700  5 Searching permissions for
>> > uid=0 mask=1
>> > 2013-12-02 08:18:59.207652 7f5308ff1700  5 Found permission: 15
>> > 2013-12-02 08:18:59.207654 7f5308ff1700 10  uid=0 requested perm
>> > (type)=1, policy perm=1, user_perm_mask=15, acl perm=1
>> > 2013-12-02 08:18:59.207669 7f5308ff1700  5 Searching permissions for
>> > uid=0 mask=2
>> > 2013-12-02 08:18:59.207670 7f5308ff1700  5 Found permission: 15
>> > 2013-12-02 08:18:59.207671 7f5308ff1700 10  uid=0 requested perm
>> > (type)=2, policy perm=2, user_perm_mask=15, acl perm=2
>> > 2013-12-02 08:18:59.207681 7f5308ff1700  2 req 237:0.011030:s3:PUT
>> > /testbucket/new_testfile.ini:copy_obj:verifying op params
>> > 2013-12-02 08:18:59.207686 7f5308ff1700  2 req 237:0.011035:s3:PUT
>> > /testbucket/new_testfile.ini:copy_obj:executing
>> > 2013-12-02 08:18:59.207699 7f5308ff1700 10 x>> x-amz-acl:public-read
>> > 2013-12-02 08:18:59.207704 7f5308ff1700 10 x>>
>> > x-amz-copy-source:/testbucket/testfile.xml
>> > 2013-12-02 08:18:59.207709 7f5308ff1700 10 x>>
>> x-amz-metadata-directive:COPY
>> > 2013-12-02 08:18:59.207759 7f5308ff1700  5 Copy object
>> > testbucket(@.rgw.buckets[406250.1]):testfile.ini =>
>> > testbucket(@.rgw.buckets[406250.1]):new_testfile.ini
>> > 2013-12-02 08:18:59.208903 7f5308ff1700 -1 *** Caught signal
>> > (Segmentation fault) **
>> >  in thread 7f5308ff1700
>> >
>> >
>> > --
>> > Regards
>> > Dominik
>>
>>
>>
>> --
>> Pozdrawiam
>> Dominik
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>

--089e015376b65c7e0104ec910f4a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Yes I can read it.=A0 Oryginal object is 0 size.</p>
<p dir=3D"ltr">Regards<br>
Dominik</p>
<div class=3D"gmail_quote">On Dec 2, 2013 6:14 PM, &quot;Yehuda Sadeh&quot;=
 &lt;<a href=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote=
:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<p dir=3D"ltr">That&#39;s unknown bug. I have a guess as to how the origina=
l object was created. Can you read the original object, but only copy fails=
?</p>
<div class=3D"gmail_quote">On Dec 2, 2013 4:53 AM, &quot;Dominik Mostowiec&=
quot; &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">d=
ominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">

Hi,<br>
I found that issue is related with &quot;ETag: ....-0&quot; (ends -0)<br>
This is known bug ?<br>
<br>
--<br>
Regards<br>
Dominik<br>
<br>
2013/12/2 Dominik Mostowiec &lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8@public.gmane.org=
m" target=3D"_blank">dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;:<br>
&gt; Hi,<br>
&gt; I have strange problem.<br>
&gt; Obj copy (0 size) killing radosgw.<br>
&gt;<br>
&gt; Head for this file:<br>
&gt; Content-Type: application/octet-stream<br>
&gt; Server: Apache/2.2.22 (Ubuntu)<br>
&gt; ETag: &quot;d41d8cd98f00b204e9800998ecf8427e-0&quot;<br>
&gt; Last-Modified: 2013-12-01T10:37:15Z<br>
&gt;<br>
&gt; rgw log.<br>
&gt; 2013-12-02 08:18:59.196651 7f5308ff1700 =A01 =3D=3D=3D=3D=3D=3D starti=
ng new request<br>
&gt; req=3D0x2be6fa0 =3D=3D=3D=3D=3D<br>
&gt; 2013-12-02 08:18:59.196709 7f5308ff1700 =A02 req 237:0.000058::::initi=
alizing<br>
&gt; 2013-12-02 08:18:59.196752 7f5308ff1700 10 meta&gt;&gt; HTTP_X_AMZ_ACL=
=3Dpublic-read<br>
&gt; 2013-12-02 08:18:59.196760 7f5308ff1700 10 meta&gt;&gt;<br>
&gt; HTTP_X_AMZ_COPY_SOURCE=3D/testbucket/testfile.xml<br>
&gt; 2013-12-02 08:18:59.196766 7f5308ff1700 10 meta&gt;&gt;<br>
&gt; HTTP_X_AMZ_METADATA_DIRECTIVE=3DCOPY<br>
&gt; 2013-12-02 08:18:59.196771 7f5308ff1700 10 x&gt;&gt; x-amz-acl:public-=
read<br>
&gt; 2013-12-02 08:18:59.196772 7f5308ff1700 10 x&gt;&gt;<br>
&gt; x-amz-copy-source:/testbucket/testfile.xml<br>
&gt; 2013-12-02 08:18:59.196773 7f5308ff1700 10 x&gt;&gt; x-amz-metadata-di=
rective:COPY<br>
&gt; 2013-12-02 08:18:59.196786 7f5308ff1700 10<br>
&gt; s-&gt;object=3D/testbucket/new_testfile.ini s-&gt;bucket=3Dtestbucket<=
br>
&gt; 2013-12-02 08:18:59.196792 7f5308ff1700 =A02 req 237:0.000141:s3:PUT<b=
r>
&gt; /testbucket/new_testfile.ini::getting op<br>
&gt; 2013-12-02 08:18:59.196797 7f5308ff1700 =A02 req 237:0.000146:s3:PUT<b=
r>
&gt; /testbucket/new_testfile.ini:copy_obj:authorizing<br>
&gt; 2013-12-02 08:18:59.200648 7f5308ff1700 10 get_canon_resource():<br>
&gt; dest=3D/testbucket/new_testfile.ini<br>
&gt; 2013-12-02 08:18:59.200661 7f5308ff1700 10 auth_hdr:<br>
&gt; PUT<br>
&gt; 1B2M2Y8AsgTpgAmY7PhCfg=3D=3D<br>
&gt; application/octet-stream<br>
&gt; Mon, 02 Dec 2013 07:18:55 GMT<br>
&gt; x-amz-acl:public-read<br>
&gt; x-amz-copy-source:/testbucket/testfile.xml<br>
&gt; x-amz-metadata-directive:COPY<br>
&gt; /testbucket/new_testfile.ini<br>
&gt; 2013-12-02 08:18:59.200717 7f5308ff1700 =A02 req 237:0.004066:s3:PUT<b=
r>
&gt; /testbucket/new_testfile.ini:copy_obj:reading permissions<br>
&gt; 2013-12-02 08:18:59.203330 7f5308ff1700 =A02 req 237:0.006679:s3:PUT<b=
r>
&gt; /testbucket/new_testfile.ini:copy_obj:verifying op permissions<br>
&gt; 2013-12-02 08:18:59.207627 7f5308ff1700 10 manifest: total_size =3D 0<=
br>
&gt; 2013-12-02 08:18:59.207649 7f5308ff1700 =A05 Searching permissions for=
<br>
&gt; uid=3D0 mask=3D1<br>
&gt; 2013-12-02 08:18:59.207652 7f5308ff1700 =A05 Found permission: 15<br>
&gt; 2013-12-02 08:18:59.207654 7f5308ff1700 10 =A0uid=3D0 requested perm<b=
r>
&gt; (type)=3D1, policy perm=3D1, user_perm_mask=3D15, acl perm=3D1<br>
&gt; 2013-12-02 08:18:59.207669 7f5308ff1700 =A05 Searching permissions for=
<br>
&gt; uid=3D0 mask=3D2<br>
&gt; 2013-12-02 08:18:59.207670 7f5308ff1700 =A05 Found permission: 15<br>
&gt; 2013-12-02 08:18:59.207671 7f5308ff1700 10 =A0uid=3D0 requested perm<b=
r>
&gt; (type)=3D2, policy perm=3D2, user_perm_mask=3D15, acl perm=3D2<br>
&gt; 2013-12-02 08:18:59.207681 7f5308ff1700 =A02 req 237:0.011030:s3:PUT<b=
r>
&gt; /testbucket/new_testfile.ini:copy_obj:verifying op params<br>
&gt; 2013-12-02 08:18:59.207686 7f5308ff1700 =A02 req 237:0.011035:s3:PUT<b=
r>
&gt; /testbucket/new_testfile.ini:copy_obj:executing<br>
&gt; 2013-12-02 08:18:59.207699 7f5308ff1700 10 x&gt;&gt; x-amz-acl:public-=
read<br>
&gt; 2013-12-02 08:18:59.207704 7f5308ff1700 10 x&gt;&gt;<br>
&gt; x-amz-copy-source:/testbucket/testfile.xml<br>
&gt; 2013-12-02 08:18:59.207709 7f5308ff1700 10 x&gt;&gt; x-amz-metadata-di=
rective:COPY<br>
&gt; 2013-12-02 08:18:59.207759 7f5308ff1700 =A05 Copy object<br>
&gt; testbucket(@.rgw.buckets[406250.1]):testfile.ini =3D&gt;<br>
&gt; testbucket(@.rgw.buckets[406250.1]):new_testfile.ini<br>
&gt; 2013-12-02 08:18:59.208903 7f5308ff1700 -1 *** Caught signal<br>
&gt; (Segmentation fault) **<br>
&gt; =A0in thread 7f5308ff1700<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Regards<br>
&gt; Dominik<br>
<br>
<br>
<br>
--<br>
Pozdrawiam<br>
Dominik<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div>
</blockquote></div>

--089e015376b65c7e0104ec910f4a--

--===============1205501141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1205501141==--
