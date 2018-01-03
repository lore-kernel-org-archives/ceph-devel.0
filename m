From: Brady Deetz <bdeetz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: formatting bytes and object counts in ceph status
 ouput
Date: Tue, 2 Jan 2018 18:09:03 -0600
Message-ID: <CADU_9qVv3Y40x_LVoZqo5JaY6HPPYvjjvoJMzJYeZ35rPAZWrQ@mail.gmail.com>
References: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6399831534882701311=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============6399831534882701311==
Content-Type: multipart/alternative; boundary="f403045ec30eed20c60561d40531"

--f403045ec30eed20c60561d40531
Content-Type: text/plain; charset="UTF-8"

I'd implement byte counters in base 2 (KB, MB, etc). MiB is annoying to us
old grumpy folk, but I'd live with it.

But, I absolutely hate that object count is in base 2. 1kg is not 1024
kilograms. We have a reason for bytes to be in base 2. Very few other
things are expected to be in base 2. A normal person looking at ceph status
would interpret 1M objects as one million.


On Jan 2, 2018 4:43 AM, "Jan Fajerski" <jfajerski-IBi9RG/b67k@public.gmane.org> wrote:

Hi lists,
Currently the ceph status output formats all numbers with binary unit
prefixes, i.e. 1MB equals 1048576 bytes and an object count of 1M equals
1048576 objects.  I received a bug report from a user that printing object
counts with a base 2 multiplier is confusing (I agree) so I opened a bug
and https://github.com/ceph/ceph/pull/19117.
In the PR discussion a couple of questions arose that I'd like to get some
opinions on:
- Should we print binary unit prefixes (MiB, GiB, ...) since that would be
technically correct?
- Should counters (like object counts) be formatted with a base 10
multiplier or  a multiplier woth base 2?

My proposal would be to both use binary unit prefixes and use base 10
multipliers for counters. I think this aligns with user expectations as
well as the relevant standard(s?).

Best,
Jan
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--f403045ec30eed20c60561d40531
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>I&#39;d implement byte counters in base 2 (KB, MB, e=
tc). MiB is annoying to us old grumpy folk, but I&#39;d live with it.=C2=A0=
<div dir=3D"auto"><br></div><div dir=3D"auto">But, I absolutely hate that o=
bject count is in base 2. 1kg is not 1024 kilograms. We have a reason for b=
ytes to be in base 2. Very few other things are expected to be in base 2. A=
 normal person looking at ceph status would interpret 1M objects as one mil=
lion.=C2=A0</div><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Jan 2, 2018 4:43 AM, &quot;Jan Fajerski&quot; &lt;<a href=3D"mailto:=
jfajerski-IBi9RG/b67k@public.gmane.org">jfajerski-IBi9RG/b67k@public.gmane.org</a>&gt; wrote:<br type=3D"attributio=
n"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">Hi lists,<br>
Currently the ceph status output formats all numbers with binary unit prefi=
xes, i.e. 1MB equals 1048576 bytes and an object count of 1M equals 1048576=
 objects.=C2=A0 I received a bug report from a user that printing object co=
unts with a base 2 multiplier is confusing (I agree) so I opened a bug and =
<a href=3D"https://github.com/ceph/ceph/pull/19117" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/ceph/ceph/p<wbr>ull/19117</a>.<br>
In the PR discussion a couple of questions arose that I&#39;d like to get s=
ome opinions on:<br>
- Should we print binary unit prefixes (MiB, GiB, ...) since that would be=
=C2=A0 technically correct?<br>
- Should counters (like object counts) be formatted with a base 10 multipli=
er or=C2=A0 a multiplier woth base 2?<br>
<br>
My proposal would be to both use binary unit prefixes and use base 10 multi=
pliers for counters. I think this aligns with user expectations as well as =
the relevant standard(s?).<br>
<br>
Best,<br>
Jan<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
</blockquote></div><br></div></div></div>

--f403045ec30eed20c60561d40531--

--===============6399831534882701311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6399831534882701311==--
