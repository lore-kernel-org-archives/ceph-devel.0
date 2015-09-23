From: wangsongbo <songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Important security noticed regarding release
 signing key
Date: Wed, 23 Sep 2015 16:50:19 +0800
Message-ID: <560267CB.60304@gmail.com>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
	<CAHRQ3VU1RFQL6AKh_CtOOeqg87wX7W5oa3n_3d8Ki9WFW=w5tw@mail.gmail.com>
	<CALqRxCw6tq0PvqMJAY1S0At1FB3cm_KPUY_bbX72Z9R_pyJ4+Q@mail.gmail.com>
	<56020F6A.9050406@gmail.com>
	<CALqRxCw=T6JFC2i-ECQJoRd_n2atMLsDQGT13aq6amDqmtC2Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1280024191=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALqRxCw=T6JFC2i-ECQJoRd_n2atMLsDQGT13aq6amDqmtC2Kw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============1280024191==
Content-Type: multipart/alternative;
 boundary="------------040109060007030806070804"

This is a multi-part message in MIME format.
--------------040109060007030806070804
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi  Ken,
     Just now, I run teuthology-suites in our testing, it failed because=20
of lacking these packages, such as=20
qemu-kvm-0.12.1.2-2.415.el6.3ceph.x86_64,=20
qemu-kvm-tools-0.12.1.2-2.415.el6.3ceph etc.
     The modify " rm ceph-extras repository config#137" remove the=20
repository , but did not solve the ansible's dependence.

     How to solve this dependence ?

Thanks and Regards,
WangSongbo

On 15/9/23 =E4=B8=8A=E5=8D=8810:50, Ken Dreyer wrote:
> Hi Songbo, It's been removed from Ansible now:
> https://github.com/ceph/ceph-cm-ansible/pull/137
>
> - Ken
>
> On Tue, Sep 22, 2015 at 8:33 PM, wangsongbo <songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
>> Hi Ken,
>>      Thanks for your reply. But in the ceph-cm-ansible project schedul=
ed by
>> teuthology, "ceph.com/packages/ceph-extras" is in used now, such as
>> qemu-kvm-0.12.1.2-2.415.el6.3ceph, qemu-kvm-tools-0.12.1.2-2.415.el6.3=
ceph
>> etc.
>>      Any new releases will be provided ?
>>
>>
>> On 15/9/22 =E4=B8=8B=E5=8D=8810:24, Ken Dreyer wrote:
>>> On Tue, Sep 22, 2015 at 2:38 AM, Songbo Wang <songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>>>> Hi, all,
>>>>           Since the last week=E2=80=98s attack, =E2=80=9Cceph.com/pa=
ckages/ceph-extras=E2=80=9D
>>>> can be
>>>> opened never, but where can I get the releases of ceph-extra now?
>>>>
>>>> Thanks and Regards,
>>>> WangSongbo
>>>>
>>> The packages in "ceph-extras" were old and subject to CVEs (the big
>>> one being VENOM, CVE-2015-3456). So I don't intend to host ceph-extra=
s
>>> in the new location.
>>>
>>> - Ken
>>


--------------040109060007030806070804
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi=C2=A0 Ken,<br>
    =C2=A0=C2=A0=C2=A0 Just now, I run teuthology-suites in our testing, =
it failed
    because of lacking these packages, such as
    qemu-kvm-0.12.1.2-2.415.el6.3ceph.x86_64,
    qemu-kvm-tools-0.12.1.2-2.415.el6.3ceph etc.=C2=A0 <br>
    =C2=A0=C2=A0=C2=A0 The modify "
    <meta charset=3D"utf-8">
    rm ceph-extras repository config#137" remove the repository , but
    did not solve the ansible's dependence.<br>
    <br>
    =C2=A0=C2=A0=C2=A0 How to solve this dependence ?<br>
    <br>
    Thanks and Regards,<br>
    WangSongbo<br>
    <br>
    <div class=3D"moz-cite-prefix">On 15/9/23 =E4=B8=8A=E5=8D=8810:50, Ke=
n Dreyer wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CALqRxCw=3DT6JFC2i-ECQJoRd_n2atMLsDQGT13aq6amDqmtC2Kw-Rq2MYuBUFGs@public.gmane.org=
ail.com"
      type=3D"cite">
      <pre wrap=3D"">Hi Songbo, It's been removed from Ansible now:
<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/ceph/ceph-c=
m-ansible/pull/137">https://github.com/ceph/ceph-cm-ansible/pull/137</a>

- Ken

On Tue, Sep 22, 2015 at 8:33 PM, wangsongbo <a class=3D"moz-txt-link-rfc2=
396E" href=3D"mailto:songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</=
a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">Hi Ken,
    Thanks for your reply. But in the ceph-cm-ansible project scheduled b=
y
teuthology, "ceph.com/packages/ceph-extras" is in used now, such as
qemu-kvm-0.12.1.2-2.415.el6.3ceph, qemu-kvm-tools-0.12.1.2-2.415.el6.3cep=
h
etc.
    Any new releases will be provided ?


On 15/9/22 =E4=B8=8B=E5=8D=8810:24, Ken Dreyer wrote:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">
On Tue, Sep 22, 2015 at 2:38 AM, Songbo Wang <a class=3D"moz-txt-link-rfc=
2396E" href=3D"mailto:songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<=
/a> wrote:
</pre>
          <blockquote type=3D"cite">
            <pre wrap=3D"">
Hi, all,
         Since the last week=E2=80=98s attack, =E2=80=9Cceph.com/packages=
/ceph-extras=E2=80=9D
can be
opened never, but where can I get the releases of ceph-extra now?

Thanks and Regards,
WangSongbo

</pre>
          </blockquote>
          <pre wrap=3D"">The packages in "ceph-extras" were old and subje=
ct to CVEs (the big
one being VENOM, CVE-2015-3456). So I don't intend to host ceph-extras
in the new location.

- Ken
</pre>
        </blockquote>
        <pre wrap=3D"">

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------040109060007030806070804--

--===============1280024191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1280024191==--
