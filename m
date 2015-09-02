From: Travis Rhoden <trhoden-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph-deploy: too many argument: --setgroup 10
Date: Wed, 2 Sep 2015 14:32:28 -0700
Message-ID: <CACkq2mqhmpFWKTWK59J=wdvNUPz3d5jeRA7Z4hYW5tkrcUf6Yg@mail.gmail.com>
References: <CAB2gnbV3LxJYxSxnz7J8ZsXxPkjhy7Ba5aN834nrFwzG-QyNOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0114324790=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAB2gnbV3LxJYxSxnz7J8ZsXxPkjhy7Ba5aN834nrFwzG-QyNOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Noah Watkins <noahwatkins-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0114324790==
Content-Type: multipart/alternative; boundary=089e0122e9f472cbd3051eca68a3

--089e0122e9f472cbd3051eca68a3
Content-Type: text/plain; charset=UTF-8

Hi Noah,

What is the ownership on /var/lib/ceph ?

ceph-deploy should only be trying to use --setgroup if /var/lib/ceph is
owned by non-root.

On a fresh install of Hammer, this should be root:root.

The --setgroup flag was added to ceph-deploy in 1.5.26.

 - Travis

On Wed, Sep 2, 2015 at 1:59 PM, Noah Watkins <noahwatkins-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I'm getting the following error using ceph-deploy to setup a cluster.
> It's Centos6.6 and I'm using Hammer and the latest ceph-deploy. It
> looks like setgroup wasn't an option in Hammer, but ceph-deploy adds
> it. Is there a trick or older version of ceph-deploy I should try?
>
> - Noah
>
> [cn67][INFO  ] Running command: sudo ceph-mon --cluster ceph --mkfs -i
> cn67 --keyring /var/lib/ceph/tmp/ceph-cn67.mon.keyring --setgroup 10
> [cn67][WARNIN] too many arguments: [--setgroup,10]
> [cn67][DEBUG ]   --conf/-c FILE    read configuration from the given
> configuration file
> [cn67][WARNIN] usage: ceph-mon -i monid [flags]
> [cn67][DEBUG ]   --id/-i ID        set ID portion of my name
> [cn67][WARNIN]   --debug_mon n
> [cn67][DEBUG ]   --name/-n TYPE.ID set name
> [cn67][WARNIN]         debug monitor level (e.g. 10)
> [cn67][DEBUG ]   --cluster NAME    set cluster name (default: ceph)
> [cn67][WARNIN]   --mkfs
> [cn67][DEBUG ]   --version         show version and quit
> [cn67][WARNIN]         build fresh monitor fs
> [cn67][DEBUG ]
> [cn67][WARNIN]   --force-sync
> [cn67][DEBUG ]   -d                run in foreground, log to stderr.
> [cn67][WARNIN]         force a sync from another mon by wiping local
> data (BE CAREFUL)
> [cn67][DEBUG ]   -f                run in foreground, log to usual
> location.
> [cn67][WARNIN]   --yes-i-really-mean-it
> [cn67][DEBUG ]   --debug_ms N      set message debug level (e.g. 1)
> [cn67][WARNIN]         mandatory safeguard for --force-sync
> [cn67][WARNIN]   --compact
> [cn67][WARNIN]         compact the monitor store
> [cn67][WARNIN]   --osdmap <filename>
> [cn67][WARNIN]         only used when --mkfs is provided: load the
> osdmap from <filename>
> [cn67][WARNIN]   --inject-monmap <filename>
> [cn67][WARNIN]         write the <filename> monmap to the local
> monitor store and exit
> [cn67][WARNIN]   --extract-monmap <filename>
> [cn67][WARNIN]         extract the monmap from the local monitor store and
> exit
> [cn67][WARNIN]   --mon-data <directory>
> [cn67][WARNIN]         where the mon store and keyring are located
> [cn67][ERROR ] RuntimeError: command returned non-zero exit status: 1
> [ceph_deploy.mon][ERROR ] Failed to execute command: ceph-mon
> --cluster ceph --mkfs -i cn67 --keyring
> /var/lib/ceph/tmp/ceph-cn67.mon.keyring --setgroup 10
> [ceph_deploy][ERROR ] GenericError: Failed to create 1 monitors
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--089e0122e9f472cbd3051eca68a3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Noah,<div><br></div><div>What is the ownership on /var/=
lib/ceph ?</div><div><br></div><div>ceph-deploy should only be trying to us=
e --setgroup if /var/lib/ceph is owned by non-root.=C2=A0</div><div><br></d=
iv><div>On a fresh install of Hammer, this should be root:root.</div><div><=
br></div><div>The --setgroup flag was added to ceph-deploy in 1.5.26.</div>=
<div><br></div><div>=C2=A0- Travis</div></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Wed, Sep 2, 2015 at 1:59 PM, Noah Watkins <=
span dir=3D"ltr">&lt;<a href=3D"mailto:noahwatkins-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_bl=
ank">noahwatkins-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">I&#39;m getting the following error using ceph-deploy to setup a cl=
uster.<br>
It&#39;s Centos6.6 and I&#39;m using Hammer and the latest ceph-deploy. It<=
br>
looks like setgroup wasn&#39;t an option in Hammer, but ceph-deploy adds<br=
>
it. Is there a trick or older version of ceph-deploy I should try?<br>
<br>
- Noah<br>
<br>
[cn67][INFO=C2=A0 ] Running command: sudo ceph-mon --cluster ceph --mkfs -i=
<br>
cn67 --keyring /var/lib/ceph/tmp/ceph-cn67.mon.keyring --setgroup 10<br>
[cn67][WARNIN] too many arguments: [--setgroup,10]<br>
[cn67][DEBUG ]=C2=A0 =C2=A0--conf/-c FILE=C2=A0 =C2=A0 read configuration f=
rom the given<br>
configuration file<br>
[cn67][WARNIN] usage: ceph-mon -i monid [flags]<br>
[cn67][DEBUG ]=C2=A0 =C2=A0--id/-i ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 set ID por=
tion of my name<br>
[cn67][WARNIN]=C2=A0 =C2=A0--debug_mon n<br>
[cn67][DEBUG ]=C2=A0 =C2=A0--name/-n <a href=3D"http://TYPE.ID" rel=3D"nore=
ferrer" target=3D"_blank">TYPE.ID</a> set name<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug monitor level (e.g. 1=
0)<br>
[cn67][DEBUG ]=C2=A0 =C2=A0--cluster NAME=C2=A0 =C2=A0 set cluster name (de=
fault: ceph)<br>
[cn67][WARNIN]=C2=A0 =C2=A0--mkfs<br>
[cn67][DEBUG ]=C2=A0 =C2=A0--version=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0show =
version and quit<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build fresh monitor fs<br>
[cn67][DEBUG ]<br>
[cn67][WARNIN]=C2=A0 =C2=A0--force-sync<br>
[cn67][DEBUG ]=C2=A0 =C2=A0-d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 run in foreground, log to stderr.<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0force a sync from another m=
on by wiping local<br>
data (BE CAREFUL)<br>
[cn67][DEBUG ]=C2=A0 =C2=A0-f=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 run in foreground, log to usual location.<br>
[cn67][WARNIN]=C2=A0 =C2=A0--yes-i-really-mean-it<br>
[cn67][DEBUG ]=C2=A0 =C2=A0--debug_ms N=C2=A0 =C2=A0 =C2=A0 set message deb=
ug level (e.g. 1)<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mandatory safeguard for --f=
orce-sync<br>
[cn67][WARNIN]=C2=A0 =C2=A0--compact<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compact the monitor store<b=
r>
[cn67][WARNIN]=C2=A0 =C2=A0--osdmap &lt;filename&gt;<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0only used when --mkfs is pr=
ovided: load the<br>
osdmap from &lt;filename&gt;<br>
[cn67][WARNIN]=C2=A0 =C2=A0--inject-monmap &lt;filename&gt;<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0write the &lt;filename&gt; =
monmap to the local<br>
monitor store and exit<br>
[cn67][WARNIN]=C2=A0 =C2=A0--extract-monmap &lt;filename&gt;<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0extract the monmap from the=
 local monitor store and exit<br>
[cn67][WARNIN]=C2=A0 =C2=A0--mon-data &lt;directory&gt;<br>
[cn67][WARNIN]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0where the mon store and key=
ring are located<br>
[cn67][ERROR ] RuntimeError: command returned non-zero exit status: 1<br>
[ceph_deploy.mon][ERROR ] Failed to execute command: ceph-mon<br>
--cluster ceph --mkfs -i cn67 --keyring<br>
/var/lib/ceph/tmp/ceph-cn67.mon.keyring --setgroup 10<br>
[ceph_deploy][ERROR ] GenericError: Failed to create 1 monitors<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</blockquote></div><br></div>

--089e0122e9f472cbd3051eca68a3--

--===============0114324790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0114324790==--
