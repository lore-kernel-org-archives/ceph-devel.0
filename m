From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 10 Mar 2011 15:40:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103101538100.20133@cobra.newdream.net>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com> <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1297985503.25491.175.camel@sale659.sandia.gov> <1299686572.4750.329.camel@sale659.sandia.gov>
 <2E7A0FAAE7EA416896A1990C7A96D59A@gmail.com> <1299695809.4750.346.camel@sale659.sandia.gov>
 <144B52A5BA504DCB992CD253287A397A@gmail.com> <1299798589.4750.372.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103101515430.20133@cobra.newdream.net>
 <1299799936.4750.378.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49768 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab1CJXiS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 18:38:18 -0500
In-Reply-To: <1299799936.4750.378.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 10 Mar 2011, Jim Schutt wrote:
> 
> On Thu, 2011-03-10 at 16:21 -0700, Sage Weil wrote:
> > On Thu, 10 Mar 2011, Jim Schutt wrote:
> > > On Wed, 2011-03-09 at 12:37 -0700, Gregory Farnum wrote:
> > > > On Wednesday, March 9, 2011 at 10:36 AM, Jim Schutt wrote:
> > > > > Here's another example with more debugging. The
> > > > > PG count during this interval is:
> > > > > 
> > > > > 2011-03-09 10:35:58.306942 pg v379: 25344 pgs: 25344 active+clean; 12119 MB data, 12025 MB used, 44579 GB / 44787 GB avail
> > > > > 2011-03-09 10:36:42.177728 pg v462: 25344 pgs: 25344 active+clean; 46375 MB data, 72672 MB used, 44520 GB / 44787 GB avail
> > > > > 
> > > > > Check out the interval 10:36:23.473356 -- 10:36:27.922262
> > > > > 
> > > > > It looks to me like a heartbeat message submission is 
> > > > > waiting on something?
> > > > 
> > > > Yes, it sure does. The only thing that should block between those output 
> > > > messages is getting the messenger lock, which *ought* be fast. Either 
> > > > there are a lot of threads trying to send messages and the heartbeat 
> > > > thread is just getting unlucky, or there's a mistake in where and how 
> > > > the messenger locks (which is certainly possible, but in a brief 
> > > > audit it looks correct).
> > > 
> > > Or, delete is broken on my systems.  With some extra diagnostics, 
> > > I get many instances of this sort of thing:
> > > 
> > > osd.10.log:946307:2011-03-10 15:38:38.519444 7fe9e1170940 -- 172.17.40.22:6808/16890 --> osd17 172.17.40.23:6805/8181 -- osd_ping(e13 as_of 13) v1 -- ?+0 0x7fe9ac4041f0
> > > osd.10.log:946348:2011-03-10 15:38:38.520124 7fe9c83c3940 -- 172.17.40.22:6808/16890 >> 172.17.40.23:6805/8181 pipe(0x16b24c0 sd=133 pgs=106 cs=1 l=0).writer encoding 310 0x7fe9ac4041f0 osd_ping(e13 as_of 13) v1
> > > osd.10.log:946349:2011-03-10 15:38:38.520142 7fe9c83c3940 -- 172.17.40.22:6808/16890 >> 172.17.40.23:6805/8181 pipe(0x16b24c0 sd=133 pgs=106 cs=1 l=0).writer sending 310 0x7fe9ac4041f0
> > > osd.10.log:946350:2011-03-10 15:38:38.520156 7fe9c83c3940 -- 172.17.40.22:6808/16890 >> 172.17.40.23:6805/8181 pipe(0x16b24c0 sd=133 pgs=106 cs=1 l=0).write_message 0x7fe9ac4041f0 osd_ping(e13 as_of 13) v1
> > > osd.10.log:949167:2011-03-10 15:38:38.800447 7fe9c8ccc940 -- 172.17.40.22:6808/16890 >> 172.17.40.23:6805/8181 pipe(0x16b24c0 sd=133 pgs=106 cs=1 l=0).reader got ack seq 310 >= 310 on 0x7fe9ac4041f0 osd_ping(e13 as_of 13) v1
> > > osd.10.log:954385:2011-03-10 15:38:46.184453 7fe9c8ccc940 RefCountedObject::put delete 0x7fe9ac4041f0 took 7.345873 secs!
> > > osd.10.log:954386:2011-03-10 15:38:46.184471 7fe9c8ccc940 -- 172.17.40.22:6808/16890 >> 172.17.40.23:6805/8181 pipe(0x16b24c0 sd=133 pgs=106 cs=1 l=0).handle_ack finished put on 0x7fe9ac4041f0
> > > 
> > > osd.10.log:954785:2011-03-10 15:38:46.192022 7fe9e1170940 -- 172.17.40.22:6808/16890 --> osd46 172.17.40.27:6820/12936 -- osd_ping(e13 as_of 13) v1 -- ?+0 0x7fe9b4823d30
> > > osd.10.log:955206:2011-03-10 15:38:46.205457 7fe9d0949940 -- 172.17.40.22:6808/16890 >> 172.17.40.27:6820/12936 pipe(0x16477c0 sd=99 pgs=74 cs=1 l=0).writer encoding 322 0x7fe9b4823d30 osd_ping(e13 as_of 13) v1
> > > osd.10.log:955207:2011-03-10 15:38:46.205480 7fe9d0949940 -- 172.17.40.22:6808/16890 >> 172.17.40.27:6820/12936 pipe(0x16477c0 sd=99 pgs=74 cs=1 l=0).writer sending 322 0x7fe9b4823d30
> > > osd.10.log:955208:2011-03-10 15:38:46.205494 7fe9d0949940 -- 172.17.40.22:6808/16890 >> 172.17.40.27:6820/12936 pipe(0x16477c0 sd=99 pgs=74 cs=1 l=0).write_message 0x7fe9b4823d30 osd_ping(e13 as_of 13) v1
> > > osd.10.log:960397:2011-03-10 15:38:46.833161 7fe9d0444940 -- 172.17.40.22:6808/16890 >> 172.17.40.27:6820/12936 pipe(0x16477c0 sd=99 pgs=74 cs=1 l=0).reader got ack seq 322 >= 322 on 0x7fe9b4823d30 osd_ping(e13 as_of 13) v1
> > > osd.10.log:969858:2011-03-10 15:38:58.211206 7fe9d0444940 RefCountedObject::put delete 0x7fe9b4823d30 took 11.378036 secs!
> > > osd.10.log:969859:2011-03-10 15:38:58.211219 7fe9d0444940 -- 172.17.40.22:6808/16890 >> 172.17.40.27:6820/12936 pipe(0x16477c0 sd=99 pgs=74 cs=1 l=0).handle_ack finished put on 0x7fe9b4823d30
> > > 
> > > Since handle_ack() is under pipe_lock, heartbeat() cannot
> > > queue new osd_ping messages until Message::put() completes,
> > > right?
> > 
> > Right.
> > 
> > > It turns out my systems don't have tcmalloc.  Do you
> > > think using it would help?
> > 
> > Hmm, maybe.  I wouldn't expect this behavior from any allocator, though!
> > 
> > Can you drill down a bit further and see if either of these is 
> > responsible?
> > 
> >   virtual ~Message() { 
> >     assert(nref.read() == 0);
> >     if (connection)
> >       connection->put();
> >     if (throttler)
> >       throttler->put(payload.length() + middle.length() + data.length());
> >   }
> > 
> > (msg/Message.h)
> 
> Hmmm, this is the patch I'm running to produce above.
> It seems pretty definitive to me; am I missing something?

	delete this;

is calling the virtual destructor ~MOSDPing(), and then ~Message(), and 
only then releasing the memory to the allocator.  ~MOSDPing doesn't do 
anything, but ~Message adjusts the throttler (which involves a mutex that 
*shouldn't* be contended :) and a connection->put(), which calls 
~Connection() and then releases memory.

My money is on the throttler, but let's see!

sage


> 
> (I moved handle_ack() implementation into .cc to make
> dout work via debug osd setting.)
> 
> >From c103fc342eec412a041188031aff484c2fd3feea Mon Sep 17 00:00:00 2001
> From: Jim Schutt <jaschut@sandia.gov>
> Date: Thu, 10 Mar 2011 16:26:43 -0700
> Subject: [PATCH] Instrument ack handling.
> 
> ---
>  src/msg/Message.h          |    8 +++++++-
>  src/msg/SimpleMessenger.cc |   17 +++++++++++++++++
>  src/msg/SimpleMessenger.h  |   15 +--------------
>  3 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/src/msg/Message.h b/src/msg/Message.h
> index 3758b1b..ac32b94 100644
> --- a/src/msg/Message.h
> +++ b/src/msg/Message.h
> @@ -154,8 +154,14 @@ struct RefCountedObject {
>    }
>    void put() {
>      //generic_dout(0) << "RefCountedObject::put " << this << " " << nref.read() << " -> " << (nref.read() - 1) << dendl;
> -    if (nref.dec() == 0)
> +    if (nref.dec() == 0) {
> +      utime_t s = g_clock.now();
>        delete this;
> +      utime_t e = g_clock.now();
> +      if (e - s > 0.5) {
> +	generic_dout(1) << "RefCountedObject::put delete " << this << " took " << e - s << " secs!" << dendl;
> +      }
> +    }
>    }
>  };
>  
> diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
> index 7df3d44..a86ced8 100644
> --- a/src/msg/SimpleMessenger.cc
> +++ b/src/msg/SimpleMessenger.cc
> @@ -2243,6 +2243,23 @@ int SimpleMessenger::Pipe::write_message(Message *m)
>    goto out;
>  }
>  
> +/* Clean up sent list */
> +void SimpleMessenger::Pipe::handle_ack(uint64_t seq)
> +{
> +  dout(15) << "reader got ack seq " << seq << dendl;
> +  // trim sent list
> +  while (!sent.empty() &&
> +	 sent.front()->get_seq() <= seq) {
> +    Message *m = sent.front();
> +    sent.pop_front();
> +    dout(10) << "reader got ack seq "
> +	     << seq << " >= " << m->get_seq() << " on " << m << " " << *m << dendl;
> +    m->put();
> +    dout(20) << "handle_ack finished put on " << m << dendl;
> +  }
> +}
> +
> +
>  
>  /********************************************
>   * SimpleMessenger
> diff --git a/src/msg/SimpleMessenger.h b/src/msg/SimpleMessenger.h
> index d6ee0df..4031836 100644
> --- a/src/msg/SimpleMessenger.h
> +++ b/src/msg/SimpleMessenger.h
> @@ -174,20 +174,7 @@ private:
>      void fail();
>  
>      void was_session_reset();
> -
> -    /* Clean up sent list */
> -    void handle_ack(uint64_t seq) {
> -      dout(15) << "reader got ack seq " << seq << dendl;
> -      // trim sent list
> -      while (!sent.empty() &&
> -          sent.front()->get_seq() <= seq) {
> -        Message *m = sent.front();
> -        sent.pop_front();
> -        dout(10) << "reader got ack seq "
> -            << seq << " >= " << m->get_seq() << " on " << m << " " << *m << dendl;
> -        m->put();
> -      }
> -    }
> +    void handle_ack(uint64_t seq);
>  
>      // threads
>      class Reader : public Thread {
> -- 
> 1.6.6
> 
> -- Jim
> 
> > 
> > Thanks!
> > sage
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
