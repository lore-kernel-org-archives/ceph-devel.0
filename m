From: Brady Deetz <bdeetz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Sat, 23 Sep 2017 00:39:02 -0500
Message-ID: <CADU_9qWUdqzOpGay14YRm-ZiGwkZaqk2ymPK=yfw86kdAdzwMw@mail.gmail.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <alpine.DEB.2.11.1709222211280.16664@piezo.novalocal>
 <CAJ4mKGbrksDnFvqF2gGb1wzrE4TK4VXALRJi+NoZqje9Ke58qg@mail.gmail.com>
 <alpine.DEB.2.11.1709230128240.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8133047182455519009=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1709230128240.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
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
Cc: Aaron Glenn <aglenn-HbEMqI9myGwyYCB5lekE3M0vGNN6ct63@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============8133047182455519009==
Content-Type: multipart/alternative; boundary="94eb2c1cee583dd28d0559d4bee2"

--94eb2c1cee583dd28d0559d4bee2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll be first to admit that most of my comments are anecdotal. But, I
suspect when it comes to storage many of us don't require a lot to get
scared back into our dark corners. In short it seems that the dev team
should get better at selecting features and delivering on the existing
scheduled cadence before shortening it. To me, the odd releases represent
feature previews for the next even release. If that's a fair way to look at
them, they could play a very important role in the stability of the even
release.

On Sep 22, 2017 8:59 PM, "Sage Weil" <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:

On Fri, 22 Sep 2017, Gregory Farnum wrote:
> On Fri, Sep 22, 2017 at 3:28 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > Here is a concrete proposal for everyone to summarily shoot down (or
> > heartily endorse, depending on how your friday is going):
> >
> > - 9 month cycle
> > - enforce a predictable release schedule with a freeze date and
> >   a release date.  (The actual .0 release of course depends on no
blocker
> >   bugs being open; not sure how zealous 'train' style projects do
> >   this.)
>
> Train projects basically commit to a feature freeze enough in advance
> of the expected release date that it's feasible, and don't let people
> fake it by rushing in stuff they "finished" the day before. I'm not
> sure if every-9-month LTSes will be more conducive to that or not =E2=80=
=94 if
> we do scheduled releases, we still fundamentally need to be able to
> say "nope, that feature we've been saying for 9 months we hope to have
> out in this LTS won't make it until the next one". And we seem pretty
> bad at that.

I'll be the first to say I'm no small part of the "we" there.  But I'm
also suggesting that's not a reason not to try to do better.  As I
said I think this will be easier than in the past because we don't
have as many headline features we're trying to wedge in.


That's excellent as long as it actually happens. Otherwise the collective
you may end up pushing worse code on a 9mo cycle than the current
theoretical 12mo cycle that is delayed when necessary. We all know that
software development never happens on time or on budget.


In any case, is there an alternative way to get to the much-desired
regular cadence?

> > - no more even/odd pattern; all stable releases are created equal.
> > - support upgrades from up to 3 releases back.
> >
> > This shortens the cycle a bit to relieve the "this feature must go in"
> > stress, without making it so short as to make the release pointless
(e.g.,
> > infernalis, kraken).  (I also think that the feature pressure is much
> > lower now than it has been in the past.)
> >
> > This creates more work for the developers because there are more upgrad=
e
> > paths to consider: we no longer have strict "choke points" (like all
> > upgrades must go through luminous).  We could reserve the option to pic=
k
> > specific choke point releases in the future, perhaps taking care to mak=
e
> > sure these are the releases that go into downstream distros.  We'll nee=
d
> > to be more systematic about the upgrade testing.
>
> This sounds generally good to me =E2=80=94 we did multiple-release upgrad=
es
> for a long time, and stuff is probably more complicated now but I
> don't think it will actually be that big a deal.
>
> 3 releases back might be a bit much though =E2=80=94 that's 27 months! (F=
or
> luminous, the beginning of 2015. Hammer.)

I'm *much* happier with 2 :) so no complaint from me.  I just heard a lot
of "2 years" and 2 releases (18 months) doesn't quite cover it.  Maybe
it's best to start with that, though?  It's still an improvement over the
current ~12 months.


A lot of vulnerabilities and bugs can come out in one year. As such, I
upgrade anything in my environment, at minimum, once a year. The "if it
ain't broke don't fix it" mentality is usually more dangerous than an
upgrade between minor releases. But... I will say that as my Ceph
environment grows, upgrades become increasingly difficult to manage and
anxiety increases with every node I add to my growing 2PB cluster.


> > Somewhat separately, several people expressed concern about having
stable
> > releases to develop against.  This is somewhat orthogonal to what users
> > need.  To that end, we can do a dev checkpoint every 1 or 2 months
> > (preferences?), where we fork a 'next' branch and stabilize all of the
> > tests before moving on.  This is good practice anyway to avoid
> > accumulating low-frequency failures in the test suite that have to be
> > squashed at the end.
>
> So this sounds like a fine idea to me, but how do we distinguish this
> from the intermediate stable releases?
>
> By which I mean, are we *really* going to do a stabilization branch
> that will never get seen by users? What kind of testing and bug fixing
> are we going to commit to doing against it, and how do we balance that
> effort with feature work?
>
> It seems like the same conflict we have now, only since the dev
> checkpoints are less important they'll lose more often. Then we'll end
> up having 9 months of scheduled work to debug for a user release
> instead of 5 months that slipped to 7 or 8...

What if we frame this stabilization period in terms of stability of the
test suite.  That gives us something concrete to aim for, lets us move on
when we reach some threshold, and aligns perfectly with the thing that
makes it hard to safely land new code (noisy test results)...


All of the text below can be summarized as me saying a 9mo release cycle is
reasonable as long as a parallel focus of delivering rock solid code is as
important as meeting an arbitrary deadline. The fact that uncertainty plays
a significant role in people holding back on upgrades from hammer should
raise a flag.

Time for a story from a cephfs jewel operator:
About a year ago, I watched a web cast you did demonstrating the dev
process for ceph where you patched a bug, ran the test suite, and packaged
the patch live. I was relieved to see that the Ceph process was organized
and not a complete wild-west after I had just deployed a little over 1PB of
cephfs.

Not long after that webcast, I very easily triggered a bug in Jewel that
crashed both of my MDS servers (active/standby) because I made a very
simple mistake by deleting a pool defined in the ceph.dir.layout xattr of a
cephfs directory. A stupid mistake, yes. But a very very easy mistake to
make. John Spray managed to track down the bug; but it still resulted in a
12 hour outage and there was absolutely nothing I could have done to
resolve the issue other than reverse time or patch the MDS code myself
(unlikely to happen quickly). I'm forever in debt to John for his work that
day.

It's precisely that experience that emotionally makes me want to wait for
an upgrade to luminous. I desperately want Bluestore, but I also like my
data and don't feel like restoring my entire cluster from tape because of a
bug some other poor soul could trigger before me.

As such, features are excellent; I'd do many things to have cephfs ec-coded
direct writes arrive on my cluster tomorrow. But, I'm willing to wait in
the name of stability and confidence. As such, bumping the release schedule
from 12 to 9 months seems like it will just rush devs to "finalize" code
for the major releases.



sage
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--94eb2c1cee583dd28d0559d4bee2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>I&#39;ll be first to admit that most of my comments =
are anecdotal. But, I suspect when it comes to storage many of us don&#39;t=
 require a lot to get scared back into our dark corners. In short it seems =
that the dev team should get better at selecting features and delivering on=
 the existing scheduled cadence before shortening it. To me, the odd releas=
es represent feature previews for the next even release. If that&#39;s a fa=
ir way to look at them, they could play a very important role in the stabil=
ity of the even release.</div><div dir=3D"auto"><div class=3D"gmail_extra" =
dir=3D"auto"><br><div class=3D"gmail_quote">On Sep 22, 2017 8:59 PM, &quot;=
Sage Weil&quot; &lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=3D"_blank">=
sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><blockquote class=
=3D"m_-3326390944653592129m_8478945761441923648quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"m_-3326390=
944653592129m_8478945761441923648quoted-text">On Fri, 22 Sep 2017, Gregory =
Farnum wrote:<br>
&gt; On Fri, Sep 22, 2017 at 3:28 PM, Sage Weil &lt;<a href=3D"mailto:sage@=
newdream.net" target=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; Here is a concrete proposal for everyone to summarily shoot down =
(or<br>
&gt; &gt; heartily endorse, depending on how your friday is going):<br>
&gt; &gt;<br>
&gt; &gt; - 9 month cycle<br>
&gt; &gt; - enforce a predictable release schedule with a freeze date and<b=
r>
&gt; &gt;=C2=A0 =C2=A0a release date.=C2=A0 (The actual .0 release of cours=
e depends on no blocker<br>
&gt; &gt;=C2=A0 =C2=A0bugs being open; not sure how zealous &#39;train&#39;=
 style projects do<br>
&gt; &gt;=C2=A0 =C2=A0this.)<br>
&gt;<br>
&gt; Train projects basically commit to a feature freeze enough in advance<=
br>
&gt; of the expected release date that it&#39;s feasible, and don&#39;t let=
 people<br>
&gt; fake it by rushing in stuff they &quot;finished&quot; the day before. =
I&#39;m not<br>
&gt; sure if every-9-month LTSes will be more conducive to that or not =E2=
=80=94 if<br>
&gt; we do scheduled releases, we still fundamentally need to be able to<br=
>
&gt; say &quot;nope, that feature we&#39;ve been saying for 9 months we hop=
e to have<br>
&gt; out in this LTS won&#39;t make it until the next one&quot;. And we see=
m pretty<br>
&gt; bad at that.<br>
<br>
</div>I&#39;ll be the first to say I&#39;m no small part of the &quot;we&qu=
ot; there.=C2=A0 But I&#39;m<br>
also suggesting that&#39;s not a reason not to try to do better.=C2=A0 As I=
<br>
said I think this will be easier than in the past because we don&#39;t<br>
have as many headline features we&#39;re trying to wedge in.<br></blockquot=
e></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That&#39;=
s excellent as long as it actually happens. Otherwise the collective you ma=
y end up pushing worse code on a 9mo cycle than the current theoretical 12m=
o cycle that is delayed when necessary. We all know that software developme=
nt never happens on time or on budget.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><block=
quote class=3D"m_-3326390944653592129m_8478945761441923648quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
In any case, is there an alternative way to get to the much-desired<br>
regular cadence?<br>
<div class=3D"m_-3326390944653592129m_8478945761441923648quoted-text"><br>
&gt; &gt; - no more even/odd pattern; all stable releases are created equal=
.<br>
&gt; &gt; - support upgrades from up to 3 releases back.<br>
&gt; &gt;<br>
&gt; &gt; This shortens the cycle a bit to relieve the &quot;this feature m=
ust go in&quot;<br>
&gt; &gt; stress, without making it so short as to make the release pointle=
ss (e.g.,<br>
&gt; &gt; infernalis, kraken).=C2=A0 (I also think that the feature pressur=
e is much<br>
&gt; &gt; lower now than it has been in the past.)<br>
&gt; &gt;<br>
&gt; &gt; This creates more work for the developers because there are more =
upgrade<br>
&gt; &gt; paths to consider: we no longer have strict &quot;choke points&qu=
ot; (like all<br>
&gt; &gt; upgrades must go through luminous).=C2=A0 We could reserve the op=
tion to pick<br>
&gt; &gt; specific choke point releases in the future, perhaps taking care =
to make<br>
&gt; &gt; sure these are the releases that go into downstream distros.=C2=
=A0 We&#39;ll need<br>
&gt; &gt; to be more systematic about the upgrade testing.<br>
&gt;<br>
&gt; This sounds generally good to me =E2=80=94 we did multiple-release upg=
rades<br>
&gt; for a long time, and stuff is probably more complicated now but I<br>
&gt; don&#39;t think it will actually be that big a deal.<br>
&gt;<br>
&gt; 3 releases back might be a bit much though =E2=80=94 that&#39;s 27 mon=
ths! (For<br>
&gt; luminous, the beginning of 2015. Hammer.)<br>
<br>
</div>I&#39;m *much* happier with 2 :) so no complaint from me.=C2=A0 I jus=
t heard a lot<br>
of &quot;2 years&quot; and 2 releases (18 months) doesn&#39;t quite cover i=
t.=C2=A0 Maybe<br>
it&#39;s best to start with that, though?=C2=A0 It&#39;s still an improveme=
nt over the<br>
current ~12 months.<br></blockquote></div></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">A lot of vulnerabilities and bugs can come out in =
one year. As such, I upgrade anything in my environment, at minimum, once a=
 year. The &quot;if it ain&#39;t broke don&#39;t fix it&quot; mentality is =
usually more dangerous than an upgrade between minor releases. But... I wil=
l say that as my Ceph environment grows, upgrades become increasingly diffi=
cult to manage and anxiety increases with every node I add to my growing 2P=
B cluster.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"m_-3326390944=
653592129m_8478945761441923648quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<div class=3D"m_-3326390944653592129m_8478945761441923648quoted-text"><br>
&gt; &gt; Somewhat separately, several people expressed concern about havin=
g stable<br>
&gt; &gt; releases to develop against.=C2=A0 This is somewhat orthogonal to=
 what users<br>
&gt; &gt; need.=C2=A0 To that end, we can do a dev checkpoint every 1 or 2 =
months<br>
&gt; &gt; (preferences?), where we fork a &#39;next&#39; branch and stabili=
ze all of the<br>
&gt; &gt; tests before moving on.=C2=A0 This is good practice anyway to avo=
id<br>
&gt; &gt; accumulating low-frequency failures in the test suite that have t=
o be<br>
&gt; &gt; squashed at the end.<br>
&gt;<br>
&gt; So this sounds like a fine idea to me, but how do we distinguish this<=
br>
&gt; from the intermediate stable releases?<br>
&gt;<br>
&gt; By which I mean, are we *really* going to do a stabilization branch<br=
>
&gt; that will never get seen by users? What kind of testing and bug fixing=
<br>
&gt; are we going to commit to doing against it, and how do we balance that=
<br>
&gt; effort with feature work?<br>
&gt;<br>
&gt; It seems like the same conflict we have now, only since the dev<br>
&gt; checkpoints are less important they&#39;ll lose more often. Then we&#3=
9;ll end<br>
&gt; up having 9 months of scheduled work to debug for a user release<br>
&gt; instead of 5 months that slipped to 7 or 8...<br>
<br>
</div>What if we frame this stabilization period in terms of stability of t=
he<br>
test suite.=C2=A0 That gives us something concrete to aim for, lets us move=
 on<br>
when we reach some threshold, and aligns perfectly with the thing that<br>
makes it hard to safely land new code (noisy test results)...<br></blockquo=
te></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><span st=
yle=3D"font-family:sans-serif">All of the text below can be summarized as m=
e saying a 9mo release cycle is reasonable as long as a parallel focus of d=
elivering rock solid code is as important as meeting an arbitrary deadline.=
=C2=A0</span>The fact that uncertainty plays a significant role in people h=
olding back on upgrades from hammer should raise a flag.=C2=A0</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Time for a story from a cephfs jewel=
 operator:</div><div dir=3D"auto">About a year ago, I watched a web cast yo=
u did demonstrating the dev process for ceph where you patched a bug, ran t=
he test suite, and packaged the patch live. I was relieved to see that the =
Ceph process was organized and not a complete wild-west after I had just de=
ployed a little over 1PB of cephfs.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Not long after that webcast, I very easily triggered a bug in J=
ewel that crashed both of my MDS servers (active/standby) because I made a =
very simple mistake by deleting a pool defined in the ceph.dir.layout xattr=
 of a cephfs directory. A stupid mistake, yes. But a very very easy mistake=
 to make. John Spray managed to track down the bug; but it still resulted i=
n a 12 hour outage and there was absolutely nothing I could have done to re=
solve the issue other than reverse time or patch the MDS code myself (unlik=
ely to happen quickly). I&#39;m forever in debt to John for his work that d=
ay.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s preci=
sely that experience that emotionally makes me want to wait for an upgrade =
to luminous. I desperately want Bluestore, but I also like my data and don&=
#39;t feel like restoring my entire cluster from tape because of a bug some=
 other poor soul could trigger before me.=C2=A0</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">As such, features are excellent; I&#39;d do many th=
ings to have cephfs ec-coded direct writes arrive on my cluster tomorrow. B=
ut, I&#39;m willing to wait in the name of stability and confidence. As suc=
h, bumping the release schedule from 12 to 9 months seems like it will just=
 rush devs to &quot;finalize&quot; code for the major releases.=C2=A0</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"m=
_-3326390944653592129m_8478945761441923648quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><font color=3D"#888888"><br>
sage</font><br>______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/listinfo<wbr>.cgi/ceph-u=
sers-ceph.com</a><br>
<br></blockquote></div><br></div></div></div>

--94eb2c1cee583dd28d0559d4bee2--

--===============8133047182455519009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8133047182455519009==--
