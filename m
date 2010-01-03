From: "Rocky Shek" <rockys@areasys.com>
Subject: Re: ceph in v2.6.33?
Date: Sun, 3 Jan 2010 09:41:28 -0800
Message-ID: <4783AE79B2161C42A5D097C8F5F83B705C3F21@area51.AREA.local>
References: <Pine.LNX.4.64.0912071511470.32397@cobra.newdream.net><alpine.LFD.2.00.0912181327200.3712@localhost.localdomain><Pine.LNX.4.64.0912181629100.29068@cobra.newdream.net><200912281205.36802.anton.vazir@gmail.com>
	<b418ca0b1001011341g5699bcd3g4355f7251577d357@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8718459772417494389=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Roland Rabben <roland@jotta.no>, Anton <anton.vazir@gmail.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.

--===============8718459772417494389==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA8C9C.5AA50452"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA8C9C.5AA50452
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Sage,

I really would like to see Ceph kernel client can be built-in the Linux =
kernel. With this Peta scalable and high performance subsystem, it will =
benefit to lots of people. It already benefit lots of national =
laboratories using Ceph in their research lab with industrial common =
platform in instead of using Sky-high pricing proprietary storage that =
locks users into the vendor. It gives users the ability to choose the =
hardware platform they are most comfortable  and ability to modify it if =
needed.

It is the industrial trend no one can stop. History will just repeat =
itself. This openstorage model will much like Red Hat and Linux did for =
the server industry in twenty first century. Ceph is one of the =
important puzzle for this current open storage.

If ceph kernel client can be integrate into Linux kernel. It will bring =
more attention to people and more users will use it and help to develop =
it. It will make it early into production ready.=20

In the bottom line, this open source and scalable ceph storage bit is =
what we need in the Linux kernel just like Brtfs in Linux, ZFS in =
opensolaris.


Rocky Shek
Product Manager
AREA Data Systems
1247 N Lakeview Ave | Suite C | Anaheim | CA | 92807
Tel:(714)993-0300 x118
www.areasys.com

-----Original Message-----
From: Roland Rabben [mailto:roland@jotta.no]
Sent: Fri 1/1/2010 1:41 PM
To: Anton
Cc: ceph-devel@lists.sourceforge.net
Subject: Re: [ceph-devel] ceph in v2.6.33?
=20
I definitly agree with your points Anton. Like you I am silently =
monitoring
this list for signs of production stability. I really like the potential =
of
CEPH and would like to help out getting it into the mainline.

Regards
Roland Rabben

2009/12/28 Anton <anton.vazir@gmail.com>

> FS with CEPH abilities is the LOOOOONG time awaited stuff, which I
> (personally) looking so much forward to stabilize - that it could be =
hardly
> expressed. I't not widelly known yet, but I think a lot of us, who =
needs
> clustered storage and did own survey of the cluster FS stuff available =
(like
> gluster, etc) - just siletntly monitor the list for the signs that =
code is
> stable enough to be used in the production. How should we show our =
demand fo
> Linus? I would really like to see kernel supporting CEPH in the =
mainline.
>
>
> On Monday 21 December 2009, Sage Weil wrote:
> > The Ceph kernel client may not make it into .33 after
> > all... in the absense of other issues, Linus would like
> > to see some user demand before merging a new subsystem.
> > If you'd like to see it in mainline sooner, now's the
> > time to speak up.
> >
> > Either way, this doesn't change too much for us. We're
> > still focusing in improving stability and fixing osd
> > performance problems, and not much else. The disk format
> > and wire protocol are very nearly stabilized. An earlier
> > merge would make it easier for people to test the system,
> > but pulling the client from the ceph tree or building the
> > standalone module will make it easier for us to manage
> > bug fixes.
> >
> > sage
> >
> > On Fri, 18 Dec 2009, Linus Torvalds wrote:
> > > On Fri, 18 Dec 2009, Sage Weil wrote:
> > > > I would still like to see ceph merged for 2.6.33.
> > > > It's certainly not production ready, but it would be
> > > > greatly beneficial to be in mainline for the same
> > > > reasons other file systems like btrfs and exofs were
> > > > merged early.
> > >
> > > So what happened to ceph is the same thing that
> > > happened to the alacrityvm pull request (Greg Haskins
> > > added to cc): I pretty much continually had a _lot_ of
> > > pull requests, and all the time the priority for the
> > > ceph and alactrityvm pull requests were just low enough
> > > on my priority list that I never felt I had the reason
> > > to look into the background enough to make an even
> > > half-assed decision of whether to pull or not.
> > >
> > > And no, "just pull" is not my default answer - if I
> > > don't have a reason, the default action is "don't
> > > pull".
> > >
> > > I used to say that "my job is to say 'no'", although
> > > I've been so good at farming out submaintainers that
> > > most of the time my real job is to pull from
> > > submaintainers who hopefully know how to say 'no'. But
> > > when it comes to whole new driver features, I'm still
> > > "no by default - tell me _why_ I should pull".
> > >
> > > So what is a new subsystem person to do?
> > >
> > > The best thing to do is to try to have users that are
> > > vocal about the feature, and talk about how great it
> > > is. Some advocates for it, in other words. Just a few
> > > other people saying "hey, I use this, it's great", is
> > > actually a big deal to me. For alacrityvm and cephfs, I
> > > didn't have that, or they just weren't loud enough for
> > > me to hear.
> > >
> > > So since you mentioned btrfs as an "early merge", I'll
> > > mention it too, as a great example of how something got
> > > merged early because it had easily gotten past my
> > > "people are asking for it" filter, to the point where
> > > _I_ was interested in trying it out personally, and
> > > asking Chris&co to tell me when it was ready.
> > >
> > > Ok, so that was somewhat unusual - I'm not suggesting
> > > you'd need to try to drum up quite _that_ much hype -
> > > but it kind of illustrates the opposite extreme of your
> > > issue. Get some PR going, get people talking about it,
> > > get people testing it out. Get people outside of your
> > > area saying "hey, I use it, and I hate having to merge
> > > it every release".
> > >
> > > Then, when I see a pull request during the merge
> > > window, the pull suddenly has a much higher priority,
> > > and I go "Ok, I know people are using this".
> > >
> > > So no astro-turfing, but real grass-roots support
> > > really does help (or top-down feedback for that matter
> > > - if a _distribution_ says "we're going to merge this
> > > in our distro regardless", that also counts as a big
> > > hint for me that people actually expect to use it and
> > > would like to not go through the pain of merging).
> > >
> > > Linus
> > > --
> > > To unsubscribe from this list: send the line
> > > "unsubscribe linux-fsdevel" in the body of a message to
> > > majordomo@vger.kernel.org More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
> >
> > ---------------------------------------------------------
> >--------------------- This SF.Net email is sponsored by
> > the Verizon Developer Community Take advantage of
> > Verizon's best-in-class app development support A
> > streamlined, 14 day to market process makes app
> > distribution fast and easy Join now and get one step
> > closer to millions of Verizon customers
> > http://p.sf.net/sfu/verizon-dev2dev
> > _______________________________________________
> > Ceph-devel mailing list
> > Ceph-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ceph-devel
>
>
>
>
>
>
> =
-------------------------------------------------------------------------=
-----
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast =
and
> easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> Ceph-devel mailing list
> Ceph-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>
>


--=20
Roland Rabben
Founder & CEO Jotta AS
Cell: +47 90 85 85 39
Phone: +47 21 04 29 00
Email: roland@jotta.no


------_=_NextPart_001_01CA8C9C.5AA50452
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: [ceph-devel] ceph in v2.6.33?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Sage,<BR>
<BR>
I really would like to see Ceph kernel client can be built-in the Linux =
kernel. With this Peta scalable and high performance subsystem, it will =
benefit to lots of people. It already benefit lots of national =
laboratories using Ceph in their research lab with industrial common =
platform in instead of using Sky-high pricing proprietary storage that =
locks users into the vendor. It gives users the ability to choose the =
hardware platform they are most comfortable&nbsp; and ability to modify =
it if needed.<BR>
<BR>
It is the industrial trend no one can stop. History will just repeat =
itself. This openstorage model will much like Red Hat and Linux did for =
the server industry in twenty first century. Ceph is one of the =
important puzzle for this current open storage.<BR>
<BR>
If ceph kernel client can be integrate into Linux kernel. It will bring =
more attention to people and more users will use it and help to develop =
it. It will make it early into production ready.<BR>
<BR>
In the bottom line, this open source and scalable ceph storage bit is =
what we need in the Linux kernel just like Brtfs in Linux, ZFS in =
opensolaris.<BR>
<BR>
<BR>
Rocky Shek<BR>
Product Manager<BR>
AREA Data Systems<BR>
1247 N Lakeview Ave | Suite C | Anaheim | CA | 92807<BR>
Tel:(714)993-0300 x118<BR>
www.areasys.com<BR>
<BR>
-----Original Message-----<BR>
From: Roland Rabben [<A =
HREF=3D"mailto:roland@jotta.no">mailto:roland@jotta.no</A>]<BR>
Sent: Fri 1/1/2010 1:41 PM<BR>
To: Anton<BR>
Cc: ceph-devel@lists.sourceforge.net<BR>
Subject: Re: [ceph-devel] ceph in v2.6.33?<BR>
<BR>
I definitly agree with your points Anton. Like you I am silently =
monitoring<BR>
this list for signs of production stability. I really like the potential =
of<BR>
CEPH and would like to help out getting it into the mainline.<BR>
<BR>
Regards<BR>
Roland Rabben<BR>
<BR>
2009/12/28 Anton &lt;anton.vazir@gmail.com&gt;<BR>
<BR>
&gt; FS with CEPH abilities is the LOOOOONG time awaited stuff, which =
I<BR>
&gt; (personally) looking so much forward to stabilize - that it could =
be hardly<BR>
&gt; expressed. I't not widelly known yet, but I think a lot of us, who =
needs<BR>
&gt; clustered storage and did own survey of the cluster FS stuff =
available (like<BR>
&gt; gluster, etc) - just siletntly monitor the list for the signs that =
code is<BR>
&gt; stable enough to be used in the production. How should we show our =
demand fo<BR>
&gt; Linus? I would really like to see kernel supporting CEPH in the =
mainline.<BR>
&gt;<BR>
&gt;<BR>
&gt; On Monday 21 December 2009, Sage Weil wrote:<BR>
&gt; &gt; The Ceph kernel client may not make it into .33 after<BR>
&gt; &gt; all... in the absense of other issues, Linus would like<BR>
&gt; &gt; to see some user demand before merging a new subsystem.<BR>
&gt; &gt; If you'd like to see it in mainline sooner, now's the<BR>
&gt; &gt; time to speak up.<BR>
&gt; &gt;<BR>
&gt; &gt; Either way, this doesn't change too much for us. We're<BR>
&gt; &gt; still focusing in improving stability and fixing osd<BR>
&gt; &gt; performance problems, and not much else. The disk format<BR>
&gt; &gt; and wire protocol are very nearly stabilized. An earlier<BR>
&gt; &gt; merge would make it easier for people to test the system,<BR>
&gt; &gt; but pulling the client from the ceph tree or building the<BR>
&gt; &gt; standalone module will make it easier for us to manage<BR>
&gt; &gt; bug fixes.<BR>
&gt; &gt;<BR>
&gt; &gt; sage<BR>
&gt; &gt;<BR>
&gt; &gt; On Fri, 18 Dec 2009, Linus Torvalds wrote:<BR>
&gt; &gt; &gt; On Fri, 18 Dec 2009, Sage Weil wrote:<BR>
&gt; &gt; &gt; &gt; I would still like to see ceph merged for =
2.6.33.<BR>
&gt; &gt; &gt; &gt; It's certainly not production ready, but it would =
be<BR>
&gt; &gt; &gt; &gt; greatly beneficial to be in mainline for the =
same<BR>
&gt; &gt; &gt; &gt; reasons other file systems like btrfs and exofs =
were<BR>
&gt; &gt; &gt; &gt; merged early.<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; So what happened to ceph is the same thing that<BR>
&gt; &gt; &gt; happened to the alacrityvm pull request (Greg Haskins<BR>
&gt; &gt; &gt; added to cc): I pretty much continually had a _lot_ =
of<BR>
&gt; &gt; &gt; pull requests, and all the time the priority for the<BR>
&gt; &gt; &gt; ceph and alactrityvm pull requests were just low =
enough<BR>
&gt; &gt; &gt; on my priority list that I never felt I had the =
reason<BR>
&gt; &gt; &gt; to look into the background enough to make an even<BR>
&gt; &gt; &gt; half-assed decision of whether to pull or not.<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; And no, &quot;just pull&quot; is not my default answer - =
if I<BR>
&gt; &gt; &gt; don't have a reason, the default action is =
&quot;don't<BR>
&gt; &gt; &gt; pull&quot;.<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; I used to say that &quot;my job is to say 'no'&quot;, =
although<BR>
&gt; &gt; &gt; I've been so good at farming out submaintainers that<BR>
&gt; &gt; &gt; most of the time my real job is to pull from<BR>
&gt; &gt; &gt; submaintainers who hopefully know how to say 'no'. =
But<BR>
&gt; &gt; &gt; when it comes to whole new driver features, I'm still<BR>
&gt; &gt; &gt; &quot;no by default - tell me _why_ I should =
pull&quot;.<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; So what is a new subsystem person to do?<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; The best thing to do is to try to have users that are<BR>
&gt; &gt; &gt; vocal about the feature, and talk about how great it<BR>
&gt; &gt; &gt; is. Some advocates for it, in other words. Just a few<BR>
&gt; &gt; &gt; other people saying &quot;hey, I use this, it's =
great&quot;, is<BR>
&gt; &gt; &gt; actually a big deal to me. For alacrityvm and cephfs, =
I<BR>
&gt; &gt; &gt; didn't have that, or they just weren't loud enough =
for<BR>
&gt; &gt; &gt; me to hear.<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; So since you mentioned btrfs as an &quot;early =
merge&quot;, I'll<BR>
&gt; &gt; &gt; mention it too, as a great example of how something =
got<BR>
&gt; &gt; &gt; merged early because it had easily gotten past my<BR>
&gt; &gt; &gt; &quot;people are asking for it&quot; filter, to the point =
where<BR>
&gt; &gt; &gt; _I_ was interested in trying it out personally, and<BR>
&gt; &gt; &gt; asking Chris&amp;co to tell me when it was ready.<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; Ok, so that was somewhat unusual - I'm not suggesting<BR>
&gt; &gt; &gt; you'd need to try to drum up quite _that_ much hype -<BR>
&gt; &gt; &gt; but it kind of illustrates the opposite extreme of =
your<BR>
&gt; &gt; &gt; issue. Get some PR going, get people talking about =
it,<BR>
&gt; &gt; &gt; get people testing it out. Get people outside of your<BR>
&gt; &gt; &gt; area saying &quot;hey, I use it, and I hate having to =
merge<BR>
&gt; &gt; &gt; it every release&quot;.<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; Then, when I see a pull request during the merge<BR>
&gt; &gt; &gt; window, the pull suddenly has a much higher priority,<BR>
&gt; &gt; &gt; and I go &quot;Ok, I know people are using =
this&quot;.<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; So no astro-turfing, but real grass-roots support<BR>
&gt; &gt; &gt; really does help (or top-down feedback for that =
matter<BR>
&gt; &gt; &gt; - if a _distribution_ says &quot;we're going to merge =
this<BR>
&gt; &gt; &gt; in our distro regardless&quot;, that also counts as a =
big<BR>
&gt; &gt; &gt; hint for me that people actually expect to use it and<BR>
&gt; &gt; &gt; would like to not go through the pain of merging).<BR>
&gt; &gt; &gt;<BR>
&gt; &gt; &gt; Linus<BR>
&gt; &gt; &gt; --<BR>
&gt; &gt; &gt; To unsubscribe from this list: send the line<BR>
&gt; &gt; &gt; &quot;unsubscribe linux-fsdevel&quot; in the body of a =
message to<BR>
&gt; &gt; &gt; majordomo@vger.kernel.org More majordomo info at<BR>
&gt; &gt; &gt; <A =
HREF=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.or=
g/majordomo-info.html</A><BR>
&gt; &gt;<BR>
&gt; &gt; ---------------------------------------------------------<BR>
&gt; &gt;--------------------- This SF.Net email is sponsored by<BR>
&gt; &gt; the Verizon Developer Community Take advantage of<BR>
&gt; &gt; Verizon's best-in-class app development support A<BR>
&gt; &gt; streamlined, 14 day to market process makes app<BR>
&gt; &gt; distribution fast and easy Join now and get one step<BR>
&gt; &gt; closer to millions of Verizon customers<BR>
&gt; &gt; <A =
HREF=3D"http://p.sf.net/sfu/verizon-dev2dev">http://p.sf.net/sfu/verizon-=
dev2dev</A><BR>
&gt; &gt; _______________________________________________<BR>
&gt; &gt; Ceph-devel mailing list<BR>
&gt; &gt; Ceph-devel@lists.sourceforge.net<BR>
&gt; &gt; <A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/ceph-devel">https://=
lists.sourceforge.net/lists/listinfo/ceph-devel</A><BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; =
-------------------------------------------------------------------------=
-----<BR>
&gt; This SF.Net email is sponsored by the Verizon Developer =
Community<BR>
&gt; Take advantage of Verizon's best-in-class app development =
support<BR>
&gt; A streamlined, 14 day to market process makes app distribution fast =
and<BR>
&gt; easy<BR>
&gt; Join now and get one step closer to millions of Verizon =
customers<BR>
&gt; <A =
HREF=3D"http://p.sf.net/sfu/verizon-dev2dev">http://p.sf.net/sfu/verizon-=
dev2dev</A><BR>
&gt; _______________________________________________<BR>
&gt; Ceph-devel mailing list<BR>
&gt; Ceph-devel@lists.sourceforge.net<BR>
&gt; <A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/ceph-devel">https://=
lists.sourceforge.net/lists/listinfo/ceph-devel</A><BR>
&gt;<BR>
&gt;<BR>
<BR>
<BR>
--<BR>
Roland Rabben<BR>
Founder &amp; CEO Jotta AS<BR>
Cell: +47 90 85 85 39<BR>
Phone: +47 21 04 29 00<BR>
Email: roland@jotta.no<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA8C9C.5AA50452--


--===============8718459772417494389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============8718459772417494389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============8718459772417494389==--
