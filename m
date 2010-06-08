From: Sage Weil <sage@newdream.net>
Subject: Re: Correct proceedure for removing ceph nodes
Date: Tue, 8 Jun 2010 11:56:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006081142200.15202@cobra.newdream.net>
References: <AANLkTimW7oNdbDnTTyPzlOlD8fr0Bw5rRybuTiHNQTmV@mail.gmail.com>
 <Pine.LNX.4.64.1006021122300.1269@cobra.newdream.net> <20100604130359.GT1211@skl-net.de>
 <Pine.LNX.4.64.1006040951210.2384@cobra.newdream.net>
 <AANLkTik0eXCX53WQ9aTYz5qmpFunTTCoTxQeK42lYWfb@mail.gmail.com>
 <Pine.LNX.4.64.1006071033460.20365@cobra.newdream.net>
 <AANLkTiluECDjr8D8wYrqRpZ7gK3iAmdRxnHrW7ouHjC2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1361167541-1276023383=:15202"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45659 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab0FHSzw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jun 2010 14:55:52 -0400
In-Reply-To: <AANLkTiluECDjr8D8wYrqRpZ7gK3iAmdRxnHrW7ouHjC2@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul <paul_chiang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1361167541-1276023383=:15202
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 8 Jun 2010, Paul wrote:
> Could you take a look at the commits at http://github.com/tcloud/ceph
> on the mon-remove branch please.

It seems to work pretty well.  I changed the LogClient interaction to be=20
less annoying, simplified the mon removal check, and did a few small=20
cleanups.  I pushed a mon-remove branch to=20
git://ceph.newdream.net/git/ceph.git.

The one remaining issue I see is the way that monitors are=20
identified/named.  We dealt with a similar issue with the MDSs a while=20
back.  The problem is that we need to identify a particular instance of=20
cmon somehow (in ceph.conf, and at startup) so that cmon knows which=20
address to bind to.  But if you have 3 monitors, identified as 0, 1, 2,=20
and remove 1, then 2 becomes 1.  We fixed things up so that the running=20
instance adjusts it's rank, but the ceph.conf is still wrong.

We could take a similar route as we did with the mds, and identify each=20
cmon instance by name and not just by number.  Then the ceph.conf entry=20
would look like

[mon.foo]
=09...

and on startup you'd run

=09$ cmon -i foo        # and not 'cmon -i 0'

That would mean adjusting the monmap to store the names of monitors.  The=
=20
numeric 'rank' would just the current position of a monitor during a=20
particular epoch.

The result would be more like

 $ ceph mon add foo 1.2.3.4:6789
 $ ceph mon remove bar
or
 $ ceph mon remove 1.2.3.6:6789

Alternatively, we could keep the monmap the same, and allow ranks to be=20
empty, so that we could have say mon 0, 2, and 3.  That would require some=
=20
MonClient changes to the code that picks a new monitor, and to any other=20
code that might assume that monmap.size() determines the range of existing=
=20
monitors.

I think I prefer the first approach, because it is easier for people to=20
identify specific instances in terms of a name (not a number with specific=
=20
constraints).  And because the MonMap encoding could be simplified anyway=
=20
(no reason for it to be an entity_inst_t vector instead of an=20
entity_addr_t vector).

sage



>=20
> The second case was partly due to the MonClient trying to contact the
> monitor in the new map that has the same id (which is now mapped to a
> different address) as the one it was talking to before. Added a patch
> for this.
>=20
> Also, about the AuthMon issue we were talking about earlier: I wasn't
> able to reproduce it afterwards. Hopefully the root cause is the same
> as above.
>=20
> Thanks,
> Paul C
>=20
> On Tue, Jun 8, 2010 at 1:38 AM, Sage Weil <sage@newdream.net> wrote:
> > On Mon, 7 Jun 2010, Paul wrote:
> >> Took a shot at implementing the remove mon command, turned out to be
> >> not _quite_ as trivial as I'd expected.
> >>
> >> The monitors need to adjust their whoami values after getting the new
> >> map, which is annoying since the value is stored in quite a few
> >> places. Ended up removing all the direct copies I could find and had
> >> them lookup the value in Monitor instead.
> >
> > Looks good.
> >
> >> The interaction with MonClient (i.e. via ceph command) needs a bit
> >> more work, but I'm not really sure how to proceed at this point. If
> >> the client happens to pick the monitor that is to be removed to send
> >> the remove command to, it'll retry with another monitor and get a
> >> "does not exist" error (because the first operation already removed
> >> it). If the client happens to pick a monitor whose id is greater than
> >> the one to be removed, it will never get an response to the command.
> >
> > Hmm. =A0If we can get the reply sent before the monmap change is broadc=
ast,
> > the first case should be avoidable. =A0I'm not sure what would case the
> > second case.
> >
> > The patches below are mangled (wordwrapped) by gmail. =A0Can you resend=
 them
> > using 'git send-email'? =A0Or if they're in a public git tree somewhere=
 I
> > can grab them from there.
> >
> > Thanks!
> > sage
> >
> >
> >>
> >> >From 1d30deea10266392328c6fbdf176b766db42c32f Mon Sep 17 00:00:00 200=
1
> >> From: Paul Chiang <paul_chiang@tcloudcomputing.com>
> >> Date: Mon, 7 Jun 2010 09:47:48 +0800
> >> Subject: [PATCH 1/2] Removed all copies of the whoami value
> >>
> >>
> >> Signed-off-by: Paul Chiang <paul_chiang@tcloudcomputing.com>
> >> ---
> >> =A0src/mon/Elector.cc | =A0 10 +++++-----
> >> =A0src/mon/Elector.h =A0| =A0 =A03 +--
> >> =A0src/mon/Monitor.cc | =A0 =A04 ++--
> >> =A0src/mon/Paxos.cc =A0 | =A0 16 ++++++++--------
> >> =A0src/mon/Paxos.h =A0 =A0| =A0 =A05 ++---
> >> =A05 files changed, 18 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/src/mon/Elector.cc b/src/mon/Elector.cc
> >> index 7f8fa62..41fde6e 100644
> >> --- a/src/mon/Elector.cc
> >> +++ b/src/mon/Elector.cc
> >> @@ -69,11 +69,11 @@ void Elector::start()
> >> =A0 =A0 =A0bump_epoch(epoch+1); =A0// odd =3D=3D election cycle
> >> =A0 =A0start_stamp =3D g_clock.now();
> >> =A0 =A0electing_me =3D true;
> >> - =A0acked_me.insert(whoami);
> >> + =A0acked_me.insert(mon->whoami);
> >>
> >> =A0 =A0// bcast to everyone else
> >> =A0 =A0for (unsigned i=3D0; i<mon->monmap->size(); ++i) {
> >> - =A0 =A0if ((int)i =3D=3D whoami) continue;
> >> + =A0 =A0if ((int)i =3D=3D mon->whoami) continue;
> >> =A0 =A0 =A0mon->messenger->send_message(new
> >> MMonElection(MMonElection::OP_PROPOSE, epoch, mon->monmap),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mon->mo=
nmap->get_inst(i));
> >> =A0 =A0}
> >> @@ -151,7 +151,7 @@ void Elector::victory()
> >> =A0 =A0for (set<int>::iterator p =3D quorum.begin();
> >> =A0 =A0 =A0 =A0 p !=3D quorum.end();
> >> =A0 =A0 =A0 =A0 ++p) {
> >> - =A0 =A0if (*p =3D=3D whoami) continue;
> >> + =A0 =A0if (*p =3D=3D mon->whoami) continue;
> >> =A0 =A0 =A0MMonElection *m =3D new MMonElection(MMonElection::OP_VICTO=
RY,
> >> epoch, mon->monmap);
> >> =A0 =A0 =A0m->quorum =3D quorum;
> >> =A0 =A0 =A0mon->messenger->send_message(m, mon->monmap->get_inst(*p));
> >> @@ -186,7 +186,7 @@ void Elector::handle_propose(MMonElection *m)
> >> =A0 =A0 =A0}
> >> =A0 =A0}
> >>
> >> - =A0if (whoami < from) {
> >> + =A0if (mon->whoami < from) {
> >> =A0 =A0 =A0// i would win over them.
> >> =A0 =A0 =A0if (leader_acked >=3D 0) { =A0 =A0 =A0 =A0// we already ack=
ed someone
> >> =A0 =A0 =A0 =A0assert(leader_acked < from); =A0// and they still win, =
of course
> >> @@ -250,7 +250,7 @@ void Elector::handle_victory(MMonElection *m)
> >> =A0 =A0dout(5) << "handle_victory from " << m->get_source() << dendl;
> >> =A0 =A0int from =3D m->get_source().num();
> >>
> >> - =A0assert(from < whoami);
> >> + =A0assert(from < mon->whoami);
> >> =A0 =A0assert(m->epoch % 2 =3D=3D 0);
> >>
> >> =A0 =A0// i should have seen this election if i'm getting the victory.
> >> diff --git a/src/mon/Elector.h b/src/mon/Elector.h
> >> index 9bfd7cb..8a21e09 100644
> >> --- a/src/mon/Elector.h
> >> +++ b/src/mon/Elector.h
> >> @@ -32,7 +32,6 @@ class Monitor;
> >> =A0class Elector {
> >> =A0 private:
> >> =A0 =A0Monitor *mon;
> >> - =A0int whoami;
> >>
> >> =A0 =A0Context *expire_event;
> >>
> >> @@ -71,7 +70,7 @@ class Elector {
> >> =A0 =A0void handle_victory(class MMonElection *m);
> >>
> >> =A0 public:
> >> - =A0Elector(Monitor *m, int w) : mon(m), whoami(w),
> >> + =A0Elector(Monitor *m) : mon(m),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0expire_even=
t(0),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0epoch(0),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0electing_me=
(false),
> >> diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
> >> index cf0b20b..db086be 100644
> >> --- a/src/mon/Monitor.cc
> >> +++ b/src/mon/Monitor.cc
> >> @@ -93,7 +93,7 @@ Monitor::Monitor(int w, MonitorStore *s, Messenger
> >> *m, MonMap *map) :
> >>
> >> =A0 =A0state(STATE_STARTING), stopping(false),
> >>
> >> - =A0elector(this, w),
> >> + =A0elector(this),
> >> =A0 =A0mon_epoch(0),
> >> =A0 =A0leader(0),
> >> =A0 =A0paxos(PAXOS_NUM), paxos_service(PAXOS_NUM),
> >> @@ -114,7 +114,7 @@ Monitor::Monitor(int w, MonitorStore *s, Messenger
> >> *m, MonMap *map) :
> >>
> >> =A0Paxos *Monitor::add_paxos(int type)
> >> =A0{
> >> - =A0Paxos *p =3D new Paxos(this, whoami, type);
> >> + =A0Paxos *p =3D new Paxos(this, type);
> >> =A0 =A0paxos[type] =3D p;
> >> =A0 =A0return p;
> >> =A0}
> >> diff --git a/src/mon/Paxos.cc b/src/mon/Paxos.cc
> >> index d10f31c..9c247e8 100644
> >> --- a/src/mon/Paxos.cc
> >> +++ b/src/mon/Paxos.cc
> >> @@ -23,7 +23,7 @@
> >>
> >> =A0#define DOUT_SUBSYS paxos
> >> =A0#undef dout_prefix
> >> -#define dout_prefix _prefix(mon, whoami, machine_name, state, last_co=
mmitted)
> >> +#define dout_prefix _prefix(mon, mon->whoami, machine_name, state,
> >> last_committed)
> >> =A0static ostream& _prefix(Monitor *mon, int whoami, const char
> >> *machine_name, int state, version_t last_committed) {
> >> =A0 =A0return *_dout << dbeginl
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 << "mon" << whoami
> >> @@ -87,7 +87,7 @@ void Paxos::collect(version_t oldpn)
> >> =A0 =A0for (set<int>::const_iterator p =3D mon->get_quorum().begin();
> >> =A0 =A0 =A0 =A0 p !=3D mon->get_quorum().end();
> >> =A0 =A0 =A0 =A0 ++p) {
> >> - =A0 =A0if (*p =3D=3D whoami) continue;
> >> + =A0 =A0if (*p =3D=3D mon->whoami) continue;
> >>
> >> =A0 =A0 =A0MMonPaxos *collect =3D new MMonPaxos(mon->get_epoch(),
> >> MMonPaxos::OP_COLLECT, machine_id);
> >> =A0 =A0 =A0collect->last_committed =3D last_committed;
> >> @@ -336,7 +336,7 @@ void Paxos::begin(bufferlist& v)
> >>
> >> =A0 =A0// accept it ourselves
> >> =A0 =A0accepted.clear();
> >> - =A0accepted.insert(whoami);
> >> + =A0accepted.insert(mon->whoami);
> >> =A0 =A0new_value =3D v;
> >> =A0 =A0mon->store->put_bl_sn(new_value, machine_name, last_committed+1=
);
> >>
> >> @@ -356,7 +356,7 @@ void Paxos::begin(bufferlist& v)
> >> =A0 =A0for (set<int>::const_iterator p =3D mon->get_quorum().begin();
> >> =A0 =A0 =A0 =A0 p !=3D mon->get_quorum().end();
> >> =A0 =A0 =A0 =A0 ++p) {
> >> - =A0 =A0if (*p =3D=3D whoami) continue;
> >> + =A0 =A0if (*p =3D=3D mon->whoami) continue;
> >>
> >> =A0 =A0 =A0dout(10) << " sending begin to mon" << *p << dendl;
> >> =A0 =A0 =A0MMonPaxos *begin =3D new MMonPaxos(mon->get_epoch(),
> >> MMonPaxos::OP_BEGIN, machine_id);
> >> @@ -483,7 +483,7 @@ void Paxos::commit()
> >> =A0 =A0for (set<int>::const_iterator p =3D mon->get_quorum().begin();
> >> =A0 =A0 =A0 =A0 p !=3D mon->get_quorum().end();
> >> =A0 =A0 =A0 =A0 ++p) {
> >> - =A0 =A0if (*p =3D=3D whoami) continue;
> >> + =A0 =A0if (*p =3D=3D mon->whoami) continue;
> >>
> >> =A0 =A0 =A0dout(10) << " sending commit to mon" << *p << dendl;
> >> =A0 =A0 =A0MMonPaxos *commit =3D new MMonPaxos(mon->get_epoch(),
> >> MMonPaxos::OP_COMMIT, machine_id);
> >> @@ -527,7 +527,7 @@ void Paxos::extend_lease()
> >> =A0 =A0lease_expire =3D g_clock.now();
> >> =A0 =A0lease_expire +=3D g_conf.mon_lease;
> >> =A0 =A0acked_lease.clear();
> >> - =A0acked_lease.insert(whoami);
> >> + =A0acked_lease.insert(mon->whoami);
> >>
> >> =A0 =A0dout(7) << "extend_lease now+" << g_conf.mon_lease << " (" <<
> >> lease_expire << ")" << dendl;
> >>
> >> @@ -535,7 +535,7 @@ void Paxos::extend_lease()
> >> =A0 =A0for (set<int>::const_iterator p =3D mon->get_quorum().begin();
> >> =A0 =A0 =A0 =A0 p !=3D mon->get_quorum().end();
> >> =A0 =A0 =A0 =A0 ++p) {
> >> - =A0 =A0if (*p =3D=3D whoami) continue;
> >> + =A0 =A0if (*p =3D=3D mon->whoami) continue;
> >> =A0 =A0 =A0MMonPaxos *lease =3D new MMonPaxos(mon->get_epoch(),
> >> MMonPaxos::OP_LEASE, machine_id);
> >> =A0 =A0 =A0lease->last_committed =3D last_committed;
> >> =A0 =A0 =A0lease->lease_timestamp =3D lease_expire;
> >> @@ -724,7 +724,7 @@ version_t Paxos::get_new_proposal_number(version_t=
 gt)
> >> =A0 =A0last_pn /=3D 100;
> >> =A0 =A0last_pn++;
> >> =A0 =A0last_pn *=3D 100;
> >> - =A0last_pn +=3D (version_t)whoami;
> >> + =A0last_pn +=3D (version_t)mon->whoami;
> >>
> >> =A0 =A0// write
> >> =A0 =A0mon->store->put_int(last_pn, machine_name, "last_pn");
> >> diff --git a/src/mon/Paxos.h b/src/mon/Paxos.h
> >> index c6eff22..9d34605 100644
> >> --- a/src/mon/Paxos.h
> >> +++ b/src/mon/Paxos.h
> >> @@ -68,7 +68,6 @@ class Paxos;
> >> =A0// i am one state machine.
> >> =A0class Paxos {
> >> =A0 =A0Monitor *mon;
> >> - =A0int whoami;
> >>
> >> =A0 =A0// my state machine info
> >> =A0 =A0int machine_id;
> >> @@ -225,8 +224,8 @@ private:
> >> =A0 =A0version_t get_new_proposal_number(version_t gt=3D0);
> >>
> >> =A0public:
> >> - =A0Paxos(Monitor *m, int w,
> >> - =A0 =A0 int mid) : mon(m), whoami(w),
> >> + =A0Paxos(Monitor *m,
> >> + =A0 =A0 int mid) : mon(m),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0machine_id(mid),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0machine_name(get_paxos_name(mid)),
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0state(STATE_RECOVERING),
> >> --
> >> 1.6.4.2
> >>
> >> >From eb7308104c33aa50195e3736483c6bf9a145a518 Mon Sep 17 00:00:00 200=
1
> >> From: Paul Chiang <paul_chiang@tcloudcomputing.com>
> >> Date: Mon, 7 Jun 2010 10:16:39 +0800
> >> Subject: [PATCH 2/2] Introduced ceph mon remove command
> >>
> >>
> >> Signed-off-by: Paul Chiang <paul_chiang@tcloudcomputing.com>
> >> ---
> >> =A0src/common/LogClient.h =A0 | =A0 =A01 +
> >> =A0src/mon/Monitor.cc =A0 =A0 =A0 | =A0 =A01 +
> >> =A0src/mon/Monitor.h =A0 =A0 =A0 =A0| =A0 =A01 +
> >> =A0src/mon/MonmapMonitor.cc | =A0 61 +++++++++++++++++++++++++++++++++=
+++++++++++++
> >> =A0src/mon/MonmapMonitor.h =A0| =A0 =A01 +
> >> =A05 files changed, 65 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/src/common/LogClient.h b/src/common/LogClient.h
> >> index 0185eec..bc5e227 100644
> >> --- a/src/common/LogClient.h
> >> +++ b/src/common/LogClient.h
> >> @@ -56,6 +56,7 @@ class LogClient : public Dispatcher {
> >> =A0 =A0void send_log();
> >> =A0 =A0void handle_log_ack(MLogAck *m);
> >> =A0 =A0void set_synchronous(bool sync) { is_synchronous =3D sync; }
> >> + =A0void set_mon(int mon_id) { mon =3D mon_id; }
> >>
> >> =A0 =A0LogClient(Messenger *m, MonMap *mm) :
> >> =A0 =A0 =A0messenger(m), monmap(mm), mon(-1), is_synchronous(false),
> >> diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
> >> index db086be..259b6ce 100644
> >> --- a/src/mon/Monitor.cc
> >> +++ b/src/mon/Monitor.cc
> >> @@ -110,6 +110,7 @@ Monitor::Monitor(int w, MonitorStore *s, Messenger
> >> *m, MonMap *map) :
> >> =A0 =A0mon_caps =3D new MonCaps();
> >> =A0 =A0mon_caps->set_allow_all(true);
> >> =A0 =A0mon_caps->text =3D "allow *";
> >> + =A0myaddr =3D map->get_inst(w).addr;
> >> =A0}
> >>
> >> =A0Paxos *Monitor::add_paxos(int type)
> >> diff --git a/src/mon/Monitor.h b/src/mon/Monitor.h
> >> index 829c506..a673972 100644
> >> --- a/src/mon/Monitor.h
> >> +++ b/src/mon/Monitor.h
> >> @@ -58,6 +58,7 @@ class Monitor : public Dispatcher {
> >> =A0public:
> >> =A0 =A0// me
> >> =A0 =A0int whoami;
> >> + =A0entity_addr_t myaddr;
> >> =A0 =A0Messenger *messenger;
> >> =A0 =A0Mutex lock;
> >>
> >> diff --git a/src/mon/MonmapMonitor.cc b/src/mon/MonmapMonitor.cc
> >> index 0aca5fb..5368ab7 100644
> >> --- a/src/mon/MonmapMonitor.cc
> >> +++ b/src/mon/MonmapMonitor.cc
> >> @@ -48,6 +48,7 @@ bool MonmapMonitor::update_from_paxos()
> >> =A0 =A0dout(10) << "update_from_paxos paxosv " << paxosv
> >> =A0 =A0 =A0 =A0 =A0<< ", my v " << mon->monmap->epoch << dendl;
> >>
> >> + =A0int original_map_size =3D mon->monmap->size();
> >> =A0 =A0//read and decode
> >> =A0 =A0monmap_bl.clear();
> >> =A0 =A0bool success =3D paxos->read(paxosv, monmap_bl);
> >> @@ -58,6 +59,20 @@ bool MonmapMonitor::update_from_paxos()
> >> =A0 =A0//save the bufferlist version in the paxos instance as well
> >> =A0 =A0paxos->stash_latest(paxosv, monmap_bl);
> >>
> >> + =A0if (original_map_size !=3D mon->monmap->size())
> >> + =A0{
> >> + =A0 =A0_update_whoami();
> >> +
> >> + =A0 =A0// call election?
> >> + =A0 =A0if (mon->monmap->size() > 1) {
> >> + =A0 =A0 =A0mon->call_election();
> >> + =A0 =A0} else {
> >> + =A0 =A0 =A0// we're standalone.
> >> + =A0 =A0 =A0set<int> q;
> >> + =A0 =A0 =A0q.insert(mon->whoami);
> >> + =A0 =A0 =A0mon->win_election(1, q);
> >> + =A0 =A0}
> >> + =A0}
> >> =A0 =A0return true;
> >> =A0}
> >>
> >> @@ -127,6 +142,8 @@ bool MonmapMonitor::preprocess_command(MMonCommand=
 *m)
> >> =A0 =A0 =A0}
> >> =A0 =A0 =A0else if (m->cmd[1] =3D=3D "add")
> >> =A0 =A0 =A0 =A0return false;
> >> + =A0 =A0else if (m->cmd[1] =3D=3D "remove")
> >> + =A0 =A0 =A0return false;
> >> =A0 =A0}
> >>
> >> =A0 =A0if (r !=3D -1) {
> >> @@ -177,6 +194,23 @@ bool MonmapMonitor::prepare_command(MMonCommand *=
m)
> >> =A0 =A0 =A0 =A0paxos->wait_for_commit(new Monitor::C_Command(mon, m, 0=
, rs,
> >> paxos->get_version()));
> >> =A0 =A0 =A0 =A0return true;
> >> =A0 =A0 =A0}
> >> + =A0 =A0else if (m->cmd.size() =3D=3D 3 && m->cmd[1] =3D=3D "remove")=
 {
> >> + =A0 =A0 =A0entity_addr_t addr;
> >> + =A0 =A0 =A0parse_ip_port(m->cmd[2].c_str(), addr);
> >> + =A0 =A0 =A0bufferlist rdata;
> >> + =A0 =A0 =A0if (!pending_map.contains(addr)) {
> >> + =A0 =A0 =A0 =A0err =3D -ENOENT;
> >> + =A0 =A0 =A0 =A0ss << "mon " << addr << " does not exist";
> >> + =A0 =A0 =A0 =A0goto out;
> >> + =A0 =A0 =A0}
> >> +
> >> + =A0 =A0 =A0pending_map.remove(addr);
> >> + =A0 =A0 =A0pending_map.last_changed =3D g_clock.now();
> >> + =A0 =A0 =A0ss << "removed mon" << " at " << addr << ", there are now=
 " <<
> >> pending_map.size() << " monitors" ;
> >> + =A0 =A0 =A0getline(ss, rs);
> >> + =A0 =A0 =A0paxos->wait_for_commit(new Monitor::C_Command(mon, m, 0, =
rs,
> >> paxos->get_version()));
> >> + =A0 =A0 =A0return true;
> >> + =A0 =A0}
> >> =A0 =A0 =A0else
> >> =A0 =A0 =A0 =A0ss << "unknown command " << m->cmd[1];
> >> =A0 =A0} else
> >> @@ -203,3 +237,30 @@ void MonmapMonitor::tick()
> >> =A0{
> >> =A0 =A0update_from_paxos();
> >> =A0}
> >> +
> >> +void MonmapMonitor::_update_whoami()
> >> +{
> >> + =A0// first check if there is any change
> >> + =A0if (mon->whoami < mon->monmap->size() &&
> >> + =A0 =A0 =A0mon->monmap->get_inst(mon->whoami).addr =3D=3D mon->myadd=
r)
> >> + =A0{
> >> + =A0 =A0return;
> >> + =A0}
> >> +
> >> + =A0// then check backwards starting from min(whoami-1, size-1) since
> >> whoami only ever decreases
> >> + =A0unsigned i=3D(mon->whoami-1) < mon->monmap->size() ?
> >> (mon->whoami-1):(mon->monmap->size()-1);
> >> + =A0for (; i>=3D0; i--)
> >> + =A0{
> >> + =A0 =A0if (mon->monmap->get_inst(i).addr =3D=3D mon->myaddr)
> >> + =A0 =A0{
> >> + =A0 =A0 =A0dout(10) << "Changing whoami from " << mon->whoami << " t=
o " <<
> >> i << dendl;
> >> + =A0 =A0 =A0mon->whoami =3D i;
> >> + =A0 =A0 =A0mon->messenger->set_myname(entity_name_t::MON(i));
> >> + =A0 =A0 =A0mon->logclient.set_mon(i);
> >> + =A0 =A0 =A0return;
> >> + =A0 =A0}
> >> + =A0}
> >> + =A0dout(0) << "Cannot find myself (mon" << mon->whoami << ", " <<
> >> mon->myaddr << ") in new monmap! I must have been removed, shutting
> >> down." << dendl;
> >> + =A0mon->shutdown();
> >> +}
> >> +
> >> diff --git a/src/mon/MonmapMonitor.h b/src/mon/MonmapMonitor.h
> >> index fbb7fa5..b14c012 100644
> >> --- a/src/mon/MonmapMonitor.h
> >> +++ b/src/mon/MonmapMonitor.h
> >> @@ -67,6 +67,7 @@ class MonmapMonitor : public PaxosService {
> >>
> >> =A0 private:
> >> =A0 =A0bufferlist monmap_bl;
> >> + =A0void _update_whoami();
> >> =A0};
> >>
> >>
> >> --
> >> 1.6.4.2
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1361167541-1276023383=:15202--
