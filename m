From: Jake Young <jak3kaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: running as non-root
Date: Sat, 6 Dec 2014 15:12:09 -0500
Message-ID: <CAMnske3uR5uusFYwkFvwdH_zaAkta7+syhOvndhamCzaz9UN0A@mail.gmail.com>
References: <alpine.DEB.2.00.1412061039550.18213@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2114975309=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1412061039550.18213-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2114975309==
Content-Type: multipart/alternative; boundary=001a1134f4a8e8f68f050991ce72

--001a1134f4a8e8f68f050991ce72
Content-Type: text/plain; charset=UTF-8

On Saturday, December 6, 2014, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> While we are on the subject of init systems and packaging, I would *love*
> to fix things up for hammer to
>
>  - create a ceph user and group
>  - add various users to ceph group (like qemu or kvm user and
> apache/www-data?)


Maybe a calamari user too

 - fix permissions on /var/log/ceph and /var/run/ceph (770?) so that qemu
> and rgw can write logs and asok files there


Yes

 - make daemons run as ceph user instead of root


I think this is the right approach


>
> The main hangup is with that last one.  As I understand it, when packages
> create users, they get a semi-random UID assigned.  That means that all
> the data on a ceph-osd disk would have a semi-random UID.  If it were
> hot-swapped into another host, the uid would be wrong.  Is there a way
> use a fixed uid?
>
>
There's no guarantee that any given uid will be available across any two
unix systems. You could pick 6789 or something uncommon, but I'm sure
someone somewhere is using any given uid.

I would take the approach that the uid shouldn't matter. Add a standard
tool to assist with osd hot swaps that would change the file permissions on
the new osd disk.  I think the osd hot swap process requires some manual
intervention anyway. The only downside is the tool would need to be run
with root permissions.

I haven't tried moving an osd disk from one node to another. Can someone
describe the process?


> Also on the roadmap is defining proper selinux policies so that these
> dameons are confined into the appropriate directories etc., but I imagine
> running as non-root is a big help (or even prerequisite?) to making that
> happen?
>
> Suggestions or comments?  Or volunteers?  We haven't had time to look at
> this yet but I think it's important!
>
> sage
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <javascript:;>
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a1134f4a8e8f68f050991ce72
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 6, 2014, Sage Weil &lt;<a href=3D"mailto:swei=
l@redhat.com">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">While we are on the subject of init systems and packaging, I would *lo=
ve*<br>
to fix things up for hammer to<br>
<br>
=C2=A0- create a ceph user and group<br>
=C2=A0- add various users to ceph group (like qemu or kvm user and<br>
apache/www-data?)</blockquote><div>=C2=A0</div><div>Maybe a=C2=A0calamari=
=C2=A0user too</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0- fix permissions on /var/log/ceph and /var/run/ceph (770?) so that q=
emu<br>
and rgw can write logs and asok files there</blockquote><div><br></div><div=
>Yes=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0- make daemons run as ceph user instead of root</blockquote><div><br>=
</div><div>I think this is the right approach</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<br>
The main hangup is with that last one.=C2=A0 As I understand it, when packa=
ges<br>
create users, they get a semi-random UID assigned.=C2=A0 That means that al=
l<br>
the data on a ceph-osd disk would have a semi-random UID.=C2=A0 If it were<=
br>
hot-swapped into another host, the uid would be wrong.=C2=A0 Is there a way=
<br>
use a fixed uid?<br>
<br></blockquote><div><br></div><div>There&#39;s no guarantee that any give=
n uid will be available across any two unix systems. You could pick 6789 or=
 something uncommon, but I&#39;m sure someone somewhere is using any given=
=C2=A0uid.=C2=A0</div><div><br></div><div>I would take the approach that th=
e uid shouldn&#39;t matter. Add a standard tool to assist with osd hot swap=
s that would change the file permissions on the new=C2=A0osd disk.=C2=A0 I=
=C2=A0think the osd hot swap process requires some manual intervention anyw=
ay. The only downside is the tool would need to be run with root permission=
s.=C2=A0</div><div><br></div><div>I haven&#39;t tried moving an osd disk fr=
om one node to another. Can someone describe the process?<span></span></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
Also on the roadmap is defining proper selinux policies so that these<br>
dameons are confined into the appropriate directories etc., but I imagine<b=
r>
running as non-root is a big help (or even prerequisite?) to making that<br=
>
happen?<br>
<br>
Suggestions or comments?=C2=A0 Or volunteers?=C2=A0 We haven&#39;t had time=
 to look at<br>
this yet but I think it&#39;s important!<br>
<br>
sage<br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;ceph-use=
rs-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&#39;)">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote>

--001a1134f4a8e8f68f050991ce72--

--===============2114975309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2114975309==--
