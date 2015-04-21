From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: CephFS development since Firefly
Date: Mon, 20 Apr 2015 20:41:53 -0600
Message-ID: <CAANLjFqZAYJqjxunDte=VDG-kaj3AjR7QwfkaUxCmpodik4eVg@mail.gmail.com>
References: <D2C06317-F79A-49E9-B40E-2AEF76E834F0@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0354387606=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <D2C06317-F79A-49E9-B40E-2AEF76E834F0-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0354387606==
Content-Type: multipart/alternative; boundary=047d7bb03a563f71dc051432fded

--047d7bb03a563f71dc051432fded
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for all your hard work on CephFS. This progress is very exciting to
hear about. I am constantly amazed at the amount of work that gets done in
Ceph in so short an amount of time.

On Mon, Apr 20, 2015 at 6:26 PM, Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> We=E2=80=99ve been hard at work on CephFS over the last year since Firefl=
y was
> released, and with Hammer coming out it seemed like a good time to go ove=
r
> some of the big developments users will find interesting. Much of this is
> cribbed from John=E2=80=99s Linux Vault talk (
> http://events.linuxfoundation.org/sites/events/files/slides/CephFS-Vault.=
pdf),
> in addition to the release notes (
> http://ceph.com/docs/master/release-notes/).
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> New Filesystem features & improvements:
>
> ceph-fuse has gained support for fcntl and flock locking. (Yan, Zheng)
> This has been in the kernel for a while but nobody had done the work to
> implement tracking structures and wire it up in userspace.
>
> ceph-fuse has gained support for soft quotas, enforced on the client side=
.
> (Yunchuan Wen) The Ubuntu Kylin guys worked on this for quite a while and
> we thank them for their work and their patience. You can now specify soft
> quotas on a directory and ceph-fuse will behave as you=E2=80=99d expect f=
rom that.
>
> Hadoop support has been generally improved and updated. (Noah Watkins,
> Huamin Chen) It now works against the 2.0 API, the tests we run in our la=
b
> are more sophisticated, and it=E2=80=99s a lot friendlier to install with=
 Maven and
> other Java tools. Noah=E2=80=99s still doing work on this to make it as t=
urnkey as
> possible, but soon you=E2=80=99ll just need to drop a single JAR on the s=
ystem
> (this will include the libcephfs stuff, so you don=E2=80=99t even need to=
 worry
> about those packages and compatibility!) and change a few config options.
>
> ceph-fuse and CephFS as a whole now have much-improved full space
> handling. If you run out of space at the RADOS layer you will get ENOSPC
> errors in the client (instead of it retrying indefinitely), and these
> errors (and others) are now propagated out to fsync and fclose calls.
>
> We are now much more consistent in our handling of timestamps. Previously
> we attempted to take the time from whichever process was responsible for
> making a change, which could be either a client or the MDS. But this was
> troublesome if their times weren=E2=80=99t synced =E2=80=94 made worse by=
 trying not to let
> the time move backwards =E2=80=94 and some applications which relied on s=
haring
> mtime and ctime values as versions (Hadoop and rsync both did this in
> certain configurations) were unhappy. We now use a timestamp provided by
> the client for all operations, which has been more stable.
>
> Certain internal data structures are now much more scalable on a
> per-client level. We had issues when certain =E2=80=9CMDSTables=E2=80=9D =
got too large, but
> John Spray sorted them out.
>
> The reconnect phase, when an MDS is restarted or dies and the clients hav=
e
> to connect to a different daemon, has been made much faster in the typica=
l
> case. (Yan, Zheng)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Administrator features & improvements:
>
> The MDS has gained an OpTracker, with functionality similar to that in th=
e
> OSD. You can dump in-flight requests and notably slow ones from the recen=
t
> past. The changes to enable this also made working with many code paths a
> lot easier.
>
> We=E2=80=99ve changed how you create and manage CephFS file systems in a =
cluster.
> (John Spray) The =E2=80=9Cdata=E2=80=9D and =E2=80=9Cmetadata=E2=80=9D po=
ols are no longer created by
> default, and the management is done via monitor commands that start with
> =E2=80=9Cceph fs=E2=80=9D (eg, =E2=80=9Cceph fs new=E2=80=9D). These have=
 been designed with future
> extensions in mind, but for now they mostly replicate existing features
> with more consistency and improved repeatability/idempotency.
>
> The MDS now reports on a variety of health metrics to the monitor, joinin=
g
> the existing OSD and monitor health reports. These include information on
> misbehaving clients and MDS data structures. (John Spray)
>
> The MDS admin socket now includes a bunch of new commands. You can examin=
e
> and evict client sessions, plus do things around filesystem repair (see
> below).
>
> The MDS now gathers metadata from the clients about who they are and
> shares that with users via a variety of helpful interfaces and warning
> messages. (John Spray)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Recovery tools
>
> We have a new MDS journal format and a new cephfs-journal-tool. (John
> Spray) This eliminates the days of needing to hexedit a journal dump in
> order to let your MDS start back up =E2=80=94 you can inspect the journal=
 state
> (human-readable or json, great for our testing!) and make changes on a
> per-event level. It also includes the ability to scan through hopelessly
> broken journals and parse out whatever data is available for flushing to
> the backing RADOS objects.
> Similarly, there=E2=80=99s a cephfs-table-tool for working with the Sessi=
onTable,
> InoTable, and SnapTable. (John Spray)
>
> We=E2=80=99ve added new =E2=80=9Cscrub_path=E2=80=9D and =E2=80=9Cflush_p=
ath=E2=80=9D commands to the admin
> socket. These are fairly limited right now but will check that both
> directories and files are self-consistent. It=E2=80=99s a building block =
for the
> "forward scrub" and fsck features that I=E2=80=99ve been working on, and =
includes a
> lot of code-level work to enable those.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Performance improvements
>
> Both the kernel and userspace clients are a lot more efficient with some
> of their =E2=80=9Ccapability=E2=80=9D and directory content handling. Thi=
s lets them serve
> a lot more out of local cache, a lot more often, than they were able to
> previously. This is particularly noticeable in workloads where a single
> client =E2=80=9Cowned=E2=80=9D a directory but another client periodicall=
y peeked in on it.
> There are also a bunch of extra improvements in this area that have gone
> in since Hammer and will be released in Infernalis. ;)
>
> The code in the MDS that handles the journaling has been split into a
> separate thread. (Yan, Zheng) This has increased maximum throughput a fai=
r
> bit and is the first major improvement enabled by John=E2=80=99s work to =
start
> breaking down the big MDS lock. (We still have a big MDS lock, but in
> addition to the journal it no longer covers the Objecter. Setting up the
> interfaces to make that manageable should make future lock sharding and
> changes a lot simpler than they would have been previously.)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Developer & test improvements
>
> In addition to a slightly expanded set of black-box tests, we are now
> testing FS behaviors to make sure everything behaves as expected in
> specific scenarios (failure and otherwise). This is largely thanks to Joh=
n,
> but we=E2=80=99re doing more with it in general as we add features that c=
an be
> tested this way.
>
> As alluded to in previous sections, we=E2=80=99ve done a lot of work that=
 makes
> the MDS codebase a lot easier to work with. Interfaces, if not exactly
> bright and shining, are a lot cleaner than they used to be. Locking is a
> lot more explicit and easier to reason about in many places. There are
> fewer special paths for specific kinds of operations, and a lot more shar=
ed
> paths that everything goes through =E2=80=94 which means we have more inv=
ariants we
> can assume on every operation.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Notable bug reductions
>
> Although we continue to leave snapshots disabled by default and don=E2=80=
=99t
> recommend multi-MDS systems, both of these have been *dramatically*
> improved by Zheng=E2=80=99s hard work. Our multimds suite now passes almo=
st all of
> the existing tests, whereas it previously failed most of them (
> http://pulpito.ceph.com/?suite=3Dmultimds). Our snapshot tests pass
> reliably and using them is no longer a shortcut to breaking your system,
> and bugs are less likely to leave your entire filesystem inaccessible.
>
>
> There=E2=80=99s a lot more I haven=E2=80=99t discussed above, like how th=
e entire stack is
> a lot more tolerant of failures elsewhere than it used to be and so bugs
> are less likely to make your entire filesystem inaccessible. But those ar=
e
> some of the biggest features and improvements that users are likely to
> notice or might have been waiting on before they decided to test it out.
> It=E2=80=99s nice to reflect occasionally =E2=80=94 I knew we were gettin=
g a lot done, but
> this list is much longer than I=E2=80=99d initially thought it would be!
> -Greg
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--047d7bb03a563f71dc051432fded
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for all your hard work on CephFS. This progress is =
very exciting to hear about. I am constantly amazed at the amount of work t=
hat gets done in Ceph in so short an amount of time.</div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Mon, Apr 20, 2015 at 6:26 PM, G=
regory Farnum <span dir=3D"ltr">&lt;<a href=3D"mailto:gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" t=
arget=3D"_blank">gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">We=E2=80=99ve been hard at work on CephFS over the last ye=
ar since Firefly was released, and with Hammer coming out it seemed like a =
good time to go over some of the big developments users will find interesti=
ng. Much of this is cribbed from John=E2=80=99s Linux Vault talk (<a href=
=3D"http://events.linuxfoundation.org/sites/events/files/slides/CephFS-Vaul=
t.pdf" target=3D"_blank">http://events.linuxfoundation.org/sites/events/fil=
es/slides/CephFS-Vault.pdf</a>), in addition to the release notes (<a href=
=3D"http://ceph.com/docs/master/release-notes/" target=3D"_blank">http://ce=
ph.com/docs/master/release-notes/</a>).<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
New Filesystem features &amp; improvements:<br>
<br>
ceph-fuse has gained support for fcntl and flock locking. (Yan, Zheng) This=
 has been in the kernel for a while but nobody had done the work to impleme=
nt tracking structures and wire it up in userspace.<br>
<br>
ceph-fuse has gained support for soft quotas, enforced on the client side. =
(Yunchuan Wen) The Ubuntu Kylin guys worked on this for quite a while and w=
e thank them for their work and their patience. You can now specify soft qu=
otas on a directory and ceph-fuse will behave as you=E2=80=99d expect from =
that.<br>
<br>
Hadoop support has been generally improved and updated. (Noah Watkins, Huam=
in Chen) It now works against the 2.0 API, the tests we run in our lab are =
more sophisticated, and it=E2=80=99s a lot friendlier to install with Maven=
 and other Java tools. Noah=E2=80=99s still doing work on this to make it a=
s turnkey as possible, but soon you=E2=80=99ll just need to drop a single J=
AR on the system (this will include the libcephfs stuff, so you don=E2=80=
=99t even need to worry about those packages and compatibility!) and change=
 a few config options.<br>
<br>
ceph-fuse and CephFS as a whole now have much-improved full space handling.=
 If you run out of space at the RADOS layer you will get ENOSPC errors in t=
he client (instead of it retrying indefinitely), and these errors (and othe=
rs) are now propagated out to fsync and fclose calls.<br>
<br>
We are now much more consistent in our handling of timestamps. Previously w=
e attempted to take the time from whichever process was responsible for mak=
ing a change, which could be either a client or the MDS. But this was troub=
lesome if their times weren=E2=80=99t synced =E2=80=94 made worse by trying=
 not to let the time move backwards =E2=80=94 and some applications which r=
elied on sharing mtime and ctime values as versions (Hadoop and rsync both =
did this in certain configurations) were unhappy. We now use a timestamp pr=
ovided by the client for all operations, which has been more stable.<br>
<br>
Certain internal data structures are now much more scalable on a per-client=
 level. We had issues when certain =E2=80=9CMDSTables=E2=80=9D got too larg=
e, but John Spray sorted them out.<br>
<br>
The reconnect phase, when an MDS is restarted or dies and the clients have =
to connect to a different daemon, has been made much faster in the typical =
case. (Yan, Zheng)<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
Administrator features &amp; improvements:<br>
<br>
The MDS has gained an OpTracker, with functionality similar to that in the =
OSD. You can dump in-flight requests and notably slow ones from the recent =
past. The changes to enable this also made working with many code paths a l=
ot easier.<br>
<br>
We=E2=80=99ve changed how you create and manage CephFS file systems in a cl=
uster. (John Spray) The =E2=80=9Cdata=E2=80=9D and =E2=80=9Cmetadata=E2=80=
=9D pools are no longer created by default, and the management is done via =
monitor commands that start with =E2=80=9Cceph fs=E2=80=9D (eg, =E2=80=9Cce=
ph fs new=E2=80=9D). These have been designed with future extensions in min=
d, but for now they mostly replicate existing features with more consistenc=
y and improved repeatability/idempotency.<br>
<br>
The MDS now reports on a variety of health metrics to the monitor, joining =
the existing OSD and monitor health reports. These include information on m=
isbehaving clients and MDS data structures. (John Spray)<br>
<br>
The MDS admin socket now includes a bunch of new commands. You can examine =
and evict client sessions, plus do things around filesystem repair (see bel=
ow).<br>
<br>
The MDS now gathers metadata from the clients about who they are and shares=
 that with users via a variety of helpful interfaces and warning messages. =
(John Spray)<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
Recovery tools<br>
<br>
We have a new MDS journal format and a new cephfs-journal-tool. (John Spray=
) This eliminates the days of needing to hexedit a journal dump in order to=
 let your MDS start back up =E2=80=94 you can inspect the journal state (hu=
man-readable or json, great for our testing!) and make changes on a per-eve=
nt level. It also includes the ability to scan through hopelessly broken jo=
urnals and parse out whatever data is available for flushing to the backing=
 RADOS objects.<br>
Similarly, there=E2=80=99s a cephfs-table-tool for working with the Session=
Table, InoTable, and SnapTable. (John Spray)<br>
<br>
We=E2=80=99ve added new =E2=80=9Cscrub_path=E2=80=9D and =E2=80=9Cflush_pat=
h=E2=80=9D commands to the admin socket. These are fairly limited right now=
 but will check that both directories and files are self-consistent. It=E2=
=80=99s a building block for the &quot;forward scrub&quot; and fsck feature=
s that I=E2=80=99ve been working on, and includes a lot of code-level work =
to enable those.<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
Performance improvements<br>
<br>
Both the kernel and userspace clients are a lot more efficient with some of=
 their =E2=80=9Ccapability=E2=80=9D and directory content handling. This le=
ts them serve a lot more out of local cache, a lot more often, than they we=
re able to previously. This is particularly noticeable in workloads where a=
 single client =E2=80=9Cowned=E2=80=9D a directory but another client perio=
dically peeked in on it.<br>
There are also a bunch of extra improvements in this area that have gone in=
 since Hammer and will be released in Infernalis. ;)<br>
<br>
The code in the MDS that handles the journaling has been split into a separ=
ate thread. (Yan, Zheng) This has increased maximum throughput a fair bit a=
nd is the first major improvement enabled by John=E2=80=99s work to start b=
reaking down the big MDS lock. (We still have a big MDS lock, but in additi=
on to the journal it no longer covers the Objecter. Setting up the interfac=
es to make that manageable should make future lock sharding and changes a l=
ot simpler than they would have been previously.)<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
Developer &amp; test improvements<br>
<br>
In addition to a slightly expanded set of black-box tests, we are now testi=
ng FS behaviors to make sure everything behaves as expected in specific sce=
narios (failure and otherwise). This is largely thanks to John, but we=E2=
=80=99re doing more with it in general as we add features that can be teste=
d this way.<br>
<br>
As alluded to in previous sections, we=E2=80=99ve done a lot of work that m=
akes the MDS codebase a lot easier to work with. Interfaces, if not exactly=
 bright and shining, are a lot cleaner than they used to be. Locking is a l=
ot more explicit and easier to reason about in many places. There are fewer=
 special paths for specific kinds of operations, and a lot more shared path=
s that everything goes through =E2=80=94 which means we have more invariant=
s we can assume on every operation.<br>
<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>
Notable bug reductions<br>
<br>
Although we continue to leave snapshots disabled by default and don=E2=80=
=99t recommend multi-MDS systems, both of these have been *dramatically* im=
proved by Zheng=E2=80=99s hard work. Our multimds suite now passes almost a=
ll of the existing tests, whereas it previously failed most of them (<a hre=
f=3D"http://pulpito.ceph.com/?suite=3Dmultimds" target=3D"_blank">http://pu=
lpito.ceph.com/?suite=3Dmultimds</a>). Our snapshot tests pass reliably and=
 using them is no longer a shortcut to breaking your system, and bugs are l=
ess likely to leave your entire filesystem inaccessible.<br>
<br>
<br>
There=E2=80=99s a lot more I haven=E2=80=99t discussed above, like how the =
entire stack is a lot more tolerant of failures elsewhere than it used to b=
e and so bugs are less likely to make your entire filesystem inaccessible. =
But those are some of the biggest features and improvements that users are =
likely to notice or might have been waiting on before they decided to test =
it out. It=E2=80=99s nice to reflect occasionally =E2=80=94 I knew we were =
getting a lot done, but this list is much longer than I=E2=80=99d initially=
 thought it would be!<br>
-Greg<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br></div>

--047d7bb03a563f71dc051432fded--

--===============0354387606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0354387606==--
