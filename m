From: "Rocky Shek" <rockys@areasys.com>
Subject: Re: ceph in v2.6.33?
Date: Mon, 21 Dec 2009 10:20:33 -0800
Message-ID: <4783AE79B2161C42A5D097C8F5F83B706B3D0B@area51.AREA.local>
References: <Pine.LNX.4.64.0912071511470.32397@cobra.newdream.net><Pine.LNX.4.64.0912181140370.26094@cobra.newdream.net><alpine.LFD.2.00.0912181327200.3712@localhost.localdomain>
	<Pine.LNX.4.64.0912181629100.29068@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0912181629100.29068@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>, ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

Sage,

I really would like to see Ceph kernel client can be built-in the Linux ker=
nel. With this Peta scalable and high performance subsystem, it will benefi=
t to lots of people. It already benefit lots of national laboratories using=
 Ceph with their research lab with industrial common platform in instead of=
 using Sky-high pricing proprietary storage that locks users into the vendo=
r. It gives users the ability to choose the hardware platform they are most=
 comfortable  and ability to modify it if needed.

It is the industrial trend no one can stop. History will just repeat itself=
. This openstorage model will much like Red Hat and Linux did for the serve=
r industry in twenty first century. Ceph is one of the important puzzle for=
 this current open storage. =


If ceph kernel client can be integrate into Linux kernel. It will bring mor=
e attention to people and more users will use it and help to develop it. It=
 will make it early into production ready.  =


In the bottom line, this open source and scalable ceph storage bit is what =
we need in the Linux kernel just like Brtfs in Linux, ZFS in opensolaris.

 =

Rocky Shek
Product Manager
AREA Data Systems
1247 N Lakeview Ave | Suite C | Anaheim | CA |=A092807
Tel:(714)993-0300 x118
www.areasys.com



-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net] =

Sent: Monday, December 21, 2009 9:07 AM
To: ceph-devel@lists.sf.net
Subject: [ceph-devel] ceph in v2.6.33?

The Ceph kernel client may not make it into .33 after all... in the =

absense of other issues, Linus would like to see some user demand before =

merging a new subsystem.  If you'd like to see it in mainline sooner, =

now's the time to speak up.

Either way, this doesn't change too much for us.  We're still focusing in =

improving stability and fixing osd performance problems, and not much =

else.  The disk format and wire protocol are very nearly stabilized.  An =

earlier merge would make it easier for people to test the system, but =

pulling the client from the ceph tree or building the standalone module =

will make it easier for us to manage bug fixes.

sage


On Fri, 18 Dec 2009, Linus Torvalds wrote:
> =

> On Fri, 18 Dec 2009, Sage Weil wrote:
> > =

> > I would still like to see ceph merged for 2.6.33.  It's certainly not =

> > production ready, but it would be greatly beneficial to be in mainline =
for =

> > the same reasons other file systems like btrfs and exofs were merged =

> > early.
> =

> So what happened to ceph is the same thing that happened to the alacrityv=
m =

> pull request (Greg Haskins added to cc): I pretty much continually had a =

> _lot_ of pull requests, and all the time the priority for the ceph and =

> alactrityvm pull requests were just low enough on my priority list that I =

> never felt I had the reason to look into the background enough to make an =

> even half-assed decision of whether to pull or not.
> =

> And no, "just pull" is not my default answer - if I don't have a reason, =

> the default action is "don't pull".
> =

> I used to say that "my job is to say 'no'", although I've been so good at =

> farming out submaintainers that most of the time my real job is to pull =

> from submaintainers who hopefully know how to say 'no'. But when it comes =

> to whole new driver features, I'm still "no by default - tell me _why_ I =

> should pull".
> =

> So what is a new subsystem person to do?
> =

> The best thing to do is to try to have users that are vocal about the =

> feature, and talk about how great it is. Some advocates for it, in other =

> words. Just a few other people saying "hey, I use this, it's great", is =

> actually a big deal to me. For alacrityvm and cephfs, I didn't have that, =

> or they just weren't loud enough for me to hear.
> =

> So since you mentioned btrfs as an "early merge", I'll mention it too, as =

> a great example of how something got merged early because it had easily =

> gotten past my "people are asking for it" filter, to the point where _I_ =

> was interested in trying it out personally, and asking Chris&co to tell m=
e =

> when it was ready.
> =

> Ok, so that was somewhat unusual - I'm not suggesting you'd need to try t=
o =

> drum up quite _that_ much hype - but it kind of illustrates the opposite =

> extreme of your issue. Get some PR going, get people talking about it, ge=
t =

> people testing it out. Get people outside of your area saying "hey, I use =

> it, and I hate having to merge it every release".
> =

> Then, when I see a pull request during the merge window, the pull suddenl=
y =

> has a much higher priority, and I go "Ok, I know people are using this".
> =

> So no astro-turfing, but real grass-roots support really does help (or =

> top-down feedback for that matter - if a _distribution_ says "we're going =

> to merge this in our distro regardless", that also counts as a big hint =

> for me that people actually expect to use it and would like to not go =

> through the pain of merging).
> =

> 			Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =

> =


---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =
