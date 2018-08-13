From: Jason Dillaman <jdillama-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RBD image "lightweight snapshots"
Date: Mon, 13 Aug 2018 11:20:48 -0400
Message-ID: <CA+aFP1CH2nFwox5W9LJhNgJiqVu52mMLqUFVh0KisxHNKhsoKA@mail.gmail.com>
References: <45c564fb-63ed-af46-851b-6467649ae56d@corp.ovh.com>
 <alpine.DEB.2.11.1808091311360.15688@piezo.novalocal>
 <cdc2a3bb-d3aa-0208-503a-e37c8bb3ed5d@ieee.org>
 <27efd295-8a87-94ea-aa77-fcaee4e5f250@sadziu.pl>
 <alpine.DEB.2.11.1808101222580.15696@piezo.novalocal>
Reply-To: dillaman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4579442002212223468=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1808101222580.15696-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: pawel.sadowski-Bj5ZXqqQV65mR6Xm/wNWPw@public.gmane.org, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Elder <elder-EkmVulN54Sk@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4579442002212223468==
Content-Type: multipart/alternative; boundary="000000000000072026057352a4e5"

--000000000000072026057352a4e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 8:29 AM Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:

> On Fri, 10 Aug 2018, Pawe=C5=82 Sadowski wrote:
> > On 08/09/2018 04:39 PM, Alex Elder wrote:
> > > On 08/09/2018 08:15 AM, Sage Weil wrote:
> > >> On Thu, 9 Aug 2018, Piotr Da=C5=82ek wrote:
> > >>> Hello,
> > >>>
> > >>> At OVH we're heavily utilizing snapshots for our backup system. We
> think
> > >>> there's an interesting optimization opportunity regarding snapshots
> I'd like
> > >>> to discuss here.
> > >>>
> > >>> The idea is to introduce a concept of a "lightweight" snapshots -
> such
> > >>> snapshot would not contain data but only the information about what
> has
> > >>> changed on the image since it was created (so basically only the
> object map
> > >>> part of snapshots).
> > >>>
> > >>> Our backup solution (which seems to be a pretty common practice) is
> as
> > >>> follows:
> > >>>
> > >>> 1. Create snapshot of the image we want to backup
> > >>> 2. If there's a previous backup snapshot, export diff and apply it
> on the
> > >>> backup image
> > >>> 3. If there's no older snapshot, just do a full backup of image
> > >>>
> > >>> This introduces one big issue: it enforces COW snapshot on image,
> meaning that
> > >>> original image access latencies and consumed space increases.
> "Lightweight"
> > >>> snapshots would remove these inefficiencies - no COW performance an=
d
> storage
> > >>> overhead.
> > >>
> > >> The snapshot in 1 would be lightweight you mean?  And you'd do the
> backup
> > >> some (short) time later based on a diff with changed extents?
> > >>
> > >> I'm pretty sure this will export a garbage image.  I mean, it will
> usually
> > >> be non-garbage, but the result won't be crash consistent, and in som=
e
> > >> (many?) cases won't be usable.
> > >>
> > >> Consider:
> > >>
> > >> - take reference snapshot
> > >> - back up this image (assume for now it is perfect)
> > >> - write A to location 1
> > >> - take lightweight snapshot
> > >> - write B to location 1
> > >> - backup process copie location 1 (B) to target
> >
> > The way I (we) see it working is a bit different:
> >  - take snapshot (1)
> >  - data write might occur, it's ok - CoW kicks in here to preserve data
> >  - export data
> >  - convert snapshot (1) to a lightweight one (not create new):
> >    * from now on just remember which blocks has been modified instead
> >      of doing CoW
> >    * you can get rid on previously CoW data blocks (they've been
> >      exported already)
> >  - more writes
> >  - take snapshot (2)
> >  - export diff - only blocks modified since snap (1)
> >  - convert snapshot (2) to a lightweight one
> >  - ...
> >
> >
> > That way I don't see a place for data corruption. Of course this has
> > some drawbacks - you can't rollback/export data from such lightweight
> > snapshot anymore. But on the other hand we are reducing need for CoW -
> > and that's the main goal with this idea. Instead of making CoW ~all the
> > time it's needed only for the time of exporting image/modified blocks.
>
> Ok, so this is a bit different.  I'm a bit fuzzy still on how the
> 'lightweight' (1) snapshot will be implemented, but basically I think
> you just mean saving on its storage overhead, but keeping enough metadata
> to make a fully consistent (2) for the purposes of the backup.
>
> Maybe Jason has a better idea for how this would work in practice?  I
> haven't thought about the RBD snapshots in a while (not above the rados
> layer at least).
>

The 'fast-diff' object map already tracks updated objects since a snapshot
was taken, so I think such an approach would just require deleting the
RADOS self-managed snapshot when converting to "lightweight" mode and then
just using the existing "--whole-object" option for "rbd export-diff" to
utilize the 'fast-diff' object map for calculating deltas instead of
relying on RADOS snap diffs.

If you don't mind getting your hands dirty writing a little Python code to
invoke "remove_self_managed_snap" using the snap id provided by "rbd snap
ls", you should be able to test it out now. If it were to be incorporated
into RBD core, I think it would need some sanity checks to ensure it relies
on 'fast-diff' when handling a lightweight snapshot. However, I would also
be interested to know if bluestore alleviates a lot of your latency
concerns given that it attempts to redirect-on-write by updating metadata
instead of copy-on-write.


> > >> That's the wrong data.  Maybe that change is harmless, but maybe
> location
> > >> 1 belongs to the filesystem journal, and you have some records that
> now
> > >> reference location 10 that as an A-era value, or haven't been writte=
n
> at
> > >> all yet, and now your file system journal won't replay and you can't
> > >> mount...
> > >
> > > Forgive me if I'm misunderstanding; this just caught my attention.
> > >
> > > The goal here seems to be to reduce the storage needed to do backups
> of an
> > > RBD image, and I think there's something to that.
> >
> > Storage reduction is only side effect here. We want to get rid of CoW a=
s
> > much as possible. In an example - we are doing snapshot every 24h - thi=
s
> > means that every 24h we will start doing CoW from the beginning on ever=
y
> > image. This has big impact on a cluster latency
> >
> > As for the storage need, with 24h backup period we see a space usage
> > increase by about 5% on our clusters. But this clearly depends on clien=
t
> > traffic.
>
> One thing to keep in mind here is that the CoW/clone overheard goes *way*
> down with BlueStore.  On FileStore we are literally blocking to make
> a copy of each 4MB object.  With BlueStore there is a bit of metadata
> overhead for the tracking but it is doing CoW at the lowest layer.
>
> Lightweight snapshots might be a big win for FileStore but that advantage
> will mostly evaporate once you repave the OSDs.
>
> sage
>
>
> > > This seems to be no different from any other incremental backup
> scheme.  It's
> > > layered, and it's ultimately based on an "epoch" complete backup imag=
e
> (what
> > > you call the reference snapshot).
> > >
> > > If you're using that model, it would be useful to be able to back up
> only
> > > the data present in a second snapshot that's the child of the referen=
ce
> > > snapshot.  (And so on, with snapshot 2 building on snapshot 1, etc.)
> > > RBD internally *knows* this information, but I'm not sure how (or
> whether)
> > > it's formally exposed.
> > >
> > > Restoring an image in this scheme requires restoring the epoch, then
> the
> > > incrementals, in order.  The cost to restore is higher, but the cost
> > > of incremental backups is significantly smaller than doing full ones.
> >
> > It depends how we will store exported data. We might just want to merge
> > all diffs into base image right after export to keep only single copy.
> > But that is out of scope of main topic here, IMHO.
> >
> > > I'm not sure how the "lightweight" snapshot would work though.  Witho=
ut
> > > references to objects there's no guarantee the data taken at the time
> of
> > > the snapshot still exists when you want to back it up.
> > >
> > >                                     -Alex
> > >
> > >>
> > >> sage
> > >>
> > >>> At first glance, it seems like it could be implemented as extension
> to current
> > >>> RBD snapshot system, leaving out the machinery required for
> copy-on-write. In
> > >>> theory it could even co-exist with regular snapshots. Removal of
> these
> > >>> "lightweight" snapshots would be instant (or near instant).
> > >>>
> > >>> So what do others think about this?
> > >>>
> > >>> --
> > >>> Piotr Da=C5=82ek
> > >>> piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org
> > >>> https://www.ovhcloud.com
> > >>> --
> > >>> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > >>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >>>
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> > > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
> > _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>


--=20
Jason

--000000000000072026057352a4e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Aug 10=
, 2018 at 8:29 AM Sage Weil &lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org">sage@n=
ewdream.net</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Fri, 10 Aug 2018, Pawe=C5=82 Sadowski wrote:<br>
&gt; On 08/09/2018 04:39 PM, Alex Elder wrote:<br>
&gt; &gt; On 08/09/2018 08:15 AM, Sage Weil wrote:<br>
&gt; &gt;&gt; On Thu, 9 Aug 2018, Piotr Da=C5=82ek wrote:<br>
&gt; &gt;&gt;&gt; Hello,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; At OVH we&#39;re heavily utilizing snapshots for our back=
up system. We think<br>
&gt; &gt;&gt;&gt; there&#39;s an interesting optimization opportunity regar=
ding snapshots I&#39;d like<br>
&gt; &gt;&gt;&gt; to discuss here.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; The idea is to introduce a concept of a &quot;lightweight=
&quot; snapshots - such<br>
&gt; &gt;&gt;&gt; snapshot would not contain data but only the information =
about what has<br>
&gt; &gt;&gt;&gt; changed on the image since it was created (so basically o=
nly the object map<br>
&gt; &gt;&gt;&gt; part of snapshots).<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Our backup solution (which seems to be a pretty common pr=
actice) is as<br>
&gt; &gt;&gt;&gt; follows:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; 1. Create snapshot of the image we want to backup<br>
&gt; &gt;&gt;&gt; 2. If there&#39;s a previous backup snapshot, export diff=
 and apply it on the<br>
&gt; &gt;&gt;&gt; backup image<br>
&gt; &gt;&gt;&gt; 3. If there&#39;s no older snapshot, just do a full backu=
p of image<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; This introduces one big issue: it enforces COW snapshot o=
n image, meaning that<br>
&gt; &gt;&gt;&gt; original image access latencies and consumed space increa=
ses. &quot;Lightweight&quot;<br>
&gt; &gt;&gt;&gt; snapshots would remove these inefficiencies - no COW perf=
ormance and storage<br>
&gt; &gt;&gt;&gt; overhead.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The snapshot in 1 would be lightweight you mean?=C2=A0 And yo=
u&#39;d do the backup <br>
&gt; &gt;&gt; some (short) time later based on a diff with changed extents?=
<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;m pretty sure this will export a garbage image.=C2=A0 I=
 mean, it will usually <br>
&gt; &gt;&gt; be non-garbage, but the result won&#39;t be crash consistent,=
 and in some <br>
&gt; &gt;&gt; (many?) cases won&#39;t be usable.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Consider:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; - take reference snapshot<br>
&gt; &gt;&gt; - back up this image (assume for now it is perfect)<br>
&gt; &gt;&gt; - write A to location 1<br>
&gt; &gt;&gt; - take lightweight snapshot<br>
&gt; &gt;&gt; - write B to location 1<br>
&gt; &gt;&gt; - backup process copie location 1 (B) to target<br>
&gt; <br>
&gt; The way I (we) see it working is a bit different:<br>
&gt;=C2=A0 - take snapshot (1)<br>
&gt;=C2=A0 - data write might occur, it&#39;s ok - CoW kicks in here to pre=
serve data<br>
&gt;=C2=A0 - export data<br>
&gt;=C2=A0 - convert snapshot (1) to a lightweight one (not create new):<br=
>
&gt;=C2=A0 =C2=A0 * from now on just remember which blocks has been modifie=
d instead<br>
&gt;=C2=A0 =C2=A0 =C2=A0 of doing CoW<br>
&gt;=C2=A0 =C2=A0 * you can get rid on previously CoW data blocks (they&#39=
;ve been<br>
&gt;=C2=A0 =C2=A0 =C2=A0 exported already)<br>
&gt;=C2=A0 - more writes<br>
&gt;=C2=A0 - take snapshot (2)<br>
&gt;=C2=A0 - export diff - only blocks modified since snap (1)<br>
&gt;=C2=A0 - convert snapshot (2) to a lightweight one<br>
&gt;=C2=A0 - ...<br>
&gt; <br>
&gt; <br>
&gt; That way I don&#39;t see a place for data corruption. Of course this h=
as<br>
&gt; some drawbacks - you can&#39;t rollback/export data from such lightwei=
ght<br>
&gt; snapshot anymore. But on the other hand we are reducing need for CoW -=
<br>
&gt; and that&#39;s the main goal with this idea. Instead of making CoW ~al=
l the<br>
&gt; time it&#39;s needed only for the time of exporting image/modified blo=
cks.<br>
<br>
Ok, so this is a bit different.=C2=A0 I&#39;m a bit fuzzy still on how the =
<br>
&#39;lightweight&#39; (1) snapshot will be implemented, but basically I thi=
nk <br>
you just mean saving on its storage overhead, but keeping enough metadata <=
br>
to make a fully consistent (2) for the purposes of the backup.<br>
<br>
Maybe Jason has a better idea for how this would work in practice?=C2=A0 I =
<br>
haven&#39;t thought about the RBD snapshots in a while (not above the rados=
 <br>
layer at least).<br></blockquote><div><br></div><div>The &#39;fast-diff&#39=
; object map already tracks updated objects since a snapshot was taken, so =
I think such an approach would just require deleting the RADOS self-managed=
 snapshot when converting to &quot;lightweight&quot; mode and then just usi=
ng the existing &quot;--whole-object&quot; option for &quot;rbd export-diff=
&quot; to utilize the &#39;fast-diff&#39; object map for calculating deltas=
 instead of relying on RADOS snap diffs.</div><div><br></div><div>If you do=
n&#39;t mind getting your hands dirty writing a little Python code to invok=
e &quot;remove_self_managed_snap&quot; using the snap id provided by &quot;=
rbd snap ls&quot;, you should be able to test it out now. If it were to be =
incorporated into RBD core, I think it would need some sanity checks to ens=
ure it relies on &#39;fast-diff&#39; when handling a lightweight snapshot. =
However, I would also be interested to know if bluestore alleviates a lot o=
f your latency concerns given that it attempts to redirect-on-write by upda=
ting metadata instead of copy-on-write.<br></div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&gt; &gt;&gt; That&#39;s the wrong data.=C2=A0 Maybe that change is harmles=
s, but maybe location <br>
&gt; &gt;&gt; 1 belongs to the filesystem journal, and you have some record=
s that now <br>
&gt; &gt;&gt; reference location 10 that as an A-era value, or haven&#39;t =
been written at <br>
&gt; &gt;&gt; all yet, and now your file system journal won&#39;t replay an=
d you can&#39;t <br>
&gt; &gt;&gt; mount...<br>
&gt; &gt; <br>
&gt; &gt; Forgive me if I&#39;m misunderstanding; this just caught my atten=
tion.<br>
&gt; &gt; <br>
&gt; &gt; The goal here seems to be to reduce the storage needed to do back=
ups of an<br>
&gt; &gt; RBD image, and I think there&#39;s something to that.<br>
&gt; <br>
&gt; Storage reduction is only side effect here. We want to get rid of CoW =
as<br>
&gt; much as possible. In an example - we are doing snapshot every 24h - th=
is<br>
&gt; means that every 24h we will start doing CoW from the beginning on eve=
ry<br>
&gt; image. This has big impact on a cluster latency<br>
&gt; <br>
&gt; As for the storage need, with 24h backup period we see a space usage<b=
r>
&gt; increase by about 5% on our clusters. But this clearly depends on clie=
nt<br>
&gt; traffic.<br>
<br>
One thing to keep in mind here is that the CoW/clone overheard goes *way* <=
br>
down with BlueStore.=C2=A0 On FileStore we are literally blocking to make <=
br>
a copy of each 4MB object.=C2=A0 With BlueStore there is a bit of metadata =
<br>
overhead for the tracking but it is doing CoW at the lowest layer.<br>
<br>
Lightweight snapshots might be a big win for FileStore but that advantage <=
br>
will mostly evaporate once you repave the OSDs.<br>
<br>
sage<br>
<br>
<br>
&gt; &gt; This seems to be no different from any other incremental backup s=
cheme.=C2=A0 It&#39;s<br>
&gt; &gt; layered, and it&#39;s ultimately based on an &quot;epoch&quot; co=
mplete backup image (what<br>
&gt; &gt; you call the reference snapshot).<br>
&gt; &gt; <br>
&gt; &gt; If you&#39;re using that model, it would be useful to be able to =
back up only<br>
&gt; &gt; the data present in a second snapshot that&#39;s the child of the=
 reference<br>
&gt; &gt; snapshot.=C2=A0 (And so on, with snapshot 2 building on snapshot =
1, etc.)<br>
&gt; &gt; RBD internally *knows* this information, but I&#39;m not sure how=
 (or whether)<br>
&gt; &gt; it&#39;s formally exposed.<br>
&gt; &gt; <br>
&gt; &gt; Restoring an image in this scheme requires restoring the epoch, t=
hen the<br>
&gt; &gt; incrementals, in order.=C2=A0 The cost to restore is higher, but =
the cost<br>
&gt; &gt; of incremental backups is significantly smaller than doing full o=
nes.<br>
&gt; <br>
&gt; It depends how we will store exported data. We might just want to merg=
e<br>
&gt; all diffs into base image right after export to keep only single copy.=
<br>
&gt; But that is out of scope of main topic here, IMHO.<br>
&gt; <br>
&gt; &gt; I&#39;m not sure how the &quot;lightweight&quot; snapshot would w=
ork though.=C2=A0 Without<br>
&gt; &gt; references to objects there&#39;s no guarantee the data taken at =
the time of<br>
&gt; &gt; the snapshot still exists when you want to back it up.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Alex<br>
&gt; &gt; <br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; sage<br>
&gt; &gt;&gt;=C2=A0 <br>
&gt; &gt;&gt;&gt; At first glance, it seems like it could be implemented as=
 extension to current<br>
&gt; &gt;&gt;&gt; RBD snapshot system, leaving out the machinery required f=
or copy-on-write. In<br>
&gt; &gt;&gt;&gt; theory it could even co-exist with regular snapshots. Rem=
oval of these<br>
&gt; &gt;&gt;&gt; &quot;lightweight&quot; snapshots would be instant (or ne=
ar instant).<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; So what do others think about this?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -- <br>
&gt; &gt;&gt;&gt; Piotr Da=C5=82ek<br>
&gt; &gt;&gt;&gt; <a href=3D"mailto:piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org" target=3D"_bl=
ank">piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org</a><br>
&gt; &gt;&gt;&gt; <a href=3D"https://www.ovhcloud.com" rel=3D"noreferrer" t=
arget=3D"_blank">https://www.ovhcloud.com</a><br>
&gt; &gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt; To unsubscribe from this list: send the line &quot;unsubs=
cribe ceph-devel&quot; in<br>
&gt; &gt;&gt;&gt; the body of a message to <a href=3D"mailto:majordomo@vger=
.kernel.org" target=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; &gt;&gt;&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kerne=
l.org/majordomo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger=
.kernel.org/majordomo-info.html</a><br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt; <br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe ce=
ph-devel&quot; in<br>
&gt; &gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TasMV2rI37PzA@public.gmane.org=
org" target=3D"_blank">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; &gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/ma=
jordomo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.=
org/majordomo-info.html</a><br>
&gt; &gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-=
ceph.com</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div=
>Jason</div></div></div></div></div></div></div>

--000000000000072026057352a4e5--

--===============4579442002212223468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4579442002212223468==--
