From: Sage Weil <sweil@redhat.com>
Subject: Re: mon config update
Date: Fri, 5 Jan 2018 21:00:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801052056481.24931@piezo.novalocal>
References: <alpine.DEB.2.11.1801051716570.24931@piezo.novalocal> <CAJ4mKGbbp8x+vru-eFgpVCuXZarqwwRtWVb3sBtU=Jgx5Z9Uuw@mail.gmail.com> <alpine.DEB.2.11.1801051815380.24931@piezo.novalocal>
 <CAJ4mKGZCTHX5FUkBYN-FPkPTj0npib83r8OfNygc3dnb4bBzZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-44371974-1515186037=:24931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbeAEVAh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 16:00:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B24B4780CD
        for <ceph-devel@vger.kernel.org>; Fri,  5 Jan 2018 21:00:37 +0000 (UTC)
In-Reply-To: <CAJ4mKGZCTHX5FUkBYN-FPkPTj0npib83r8OfNygc3dnb4bBzZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-44371974-1515186037=:24931
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 5 Jan 2018, Gregory Farnum wrote:
> On Fri, Jan 5, 2018 at 10:24 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Fri, 5 Jan 2018, Gregory Farnum wrote:
> >> On Fri, Jan 5, 2018 at 9:35 AM, Sage Weil <sweil@redhat.com> wrote:
> >> > My mon-based config branch is coming together.  The last bit I did was the
> >> > CLI commands to set and show config.  It didn't come out quite like I
> >> > expected it would.  Here's what there is:
> >> >
> >> > config dump                                     Show all configuration option(s)
> >> > config get <who> {<key>}                        Show configuration option(s) for an entity
> >> > config rm <who> <name>                          Clear a configuration option for one or more
> >> >                                                  entities
> >> > config set <who> <name> <value>                 Cet a configuration option for one or more
> >> >                                                  entities
> >> > config show <who>                               Show running configuration
> >> >
> >> > The show command is the oddball here: it reports what the *daemon* reports
> >> > as the running config, which includes other inputs (conf file, overrides,
> >> > etc.), while the 'get' and 'dump' are just what the mon stores.  I wonder
> >> > if there is a better command than 'show'?  Maybe 'running' or 'active' or
> >> > 'report' or something?
> >>
> >> I don't have a good suggestion for this name, but I was a little
> >> puzzled until I realized it seems to only show the options which are
> >> non-default? Given that defaults can change across software versions,
> >> I'm not sure that's a feasible long-term strategy. (In addition to
> >> dealing with whether we're comparing against the defaults on the OSD
> >> version or the monitor version, if I get a dump of options from
> >> somebody to do debugging with I'm not going to remember that a timeout
> >> changed between point releases and they're operating differently!)
> >>
> >> Although I definitely get the desire to make the config legible when
> >> dumped, I'm not sure there's much utility there as a default anyway —
> >> won't admins mostly be querying for a specific value or else running
> >> diffs between different dumps? Perhaps we can deal with the bad naming
> >> by having "ceph config show non-default <who>", "ceph config show
> >> current <who>", and whatever else we like.
> >
> > Yeah, defaults are excluded because there are 1000+ options and the output
> > becomes unusable.  I'd prefer to make the less-standard command the one
> > that dumps everything (including defaults), like show-all, or similar.
> > Note though that currently the daemons aren't reporting their default
> > values to the mgr at all--this keeps the MMgrReport message smaller.
> 
> Hmm. Like I said, this is going to kill somebody on debugging someday.
> I think we just need to eat it. (We could only send the config options
> when one changes, if we're worried about their size or parsing cost.)

I'll have the default values reported on mgr session open only; that 
should be lightweight.

and 'ceph config show-all' or '... show-with-defaults'?

> >> (Maybe options for showing configs under USER, ADVANCED, and DEV?)
> >
> > Oh yeah, I forgot about these!  I guess I should add columns for these for
> > both 'dump' and 'get'?
> >
> > Also, I guess the other main missing piece is 'ceph config help <option>',
> > which should present a friendly summary of the option, its description,
> > defaults, and so on?
> >
> >> Looking at the output, the WHO versus MASK bit is a little thorny. Can
> >> you show what it looks like when there are multiple masks on the same
> >> option?
> >
> > gnit:build (wip-config) 12:15 PM $ bin/ceph config set osd/class:ssd/host:gnit debug_bluestore 20
> > gnit:build (wip-config) 12:15 PM $ bin/ceph config get osd.0 debug_bluestore
> > WHO MASK                OPTION          VALUE
> > osd host:gnit/class:ssd debug_bluestore 20/20
> > gnit:build (wip-config) 12:15 PM $ bin/ceph config set osd.0/class:ssd/host:gnit debug_bluestore 21
> > gnit:build (wip-config) 12:15 PM $ bin/ceph config get osd.0 debug_bluestore
> > WHO   MASK                OPTION          VALUE
> > osd.0 host:gnit/class:ssd debug_bluestore 21/21
> 
> I was unclear. I mean, what's it look like when there's a setting for
> osd/class:ssd and a different setting for osd/class:hdd? ...which I
> now realize you did have, but I missed it and that's a good
> illustration for what I meant. See end of email.
> 
> >> It looks like things are dumped in config declaration order, right?
> >> Given that, maybe OPTION should be the "top" (leftmost) column and
> >> then WHO and MASK can be filed underneath it, with nicely indented
> >> output to make it more like a tree.
> >> Or else make it more like a tree in the other direction, with either
> >> WHO or MASK as the root and with output order controlled that way. But
> >> that probably involved a lot more repetition of the output.
> >
> > They're sorted by section (global, type, daemon), then by option name.
> > Indenting is a great idea... I'd probably indent just the 'who' portion,
> > like so?  Is that what you mean?
> >
> > WHO            MASK                OPTION                                       VALUE
> > global                             crush_chooseleaf_type                        0
> > global                             mon_pg_warn_min_per_osd                      3
> > global                             osd_pool_default_min_size                    1
> > global                             osd_pool_default_size                        1
> >   client                           admin_socket                                 /tmp/ceph-asok.A5CIZs/$name.$pid.asok
> >   client                           log_file                                     /home/sage/src/ceph6/build/out/$name.$pid.log
> >     client.rgw                     rgw_crypt_require_ssl                        false
> >     client.rgw                     rgw_crypt_s3_kms_encryption_keys             testkey-1=YmluCmJvb3N0CmJvb3N0LWJ1aWxkCmNlcGguY29uZgo= testkey-2=aWIKTWFrZWZpbGUKbWFuCm91dApzcmMKVGVzdGluZwo=
> >     client.rgw                     rgw_frontends                                civetweb port=8000
> >     client.rgw                     rgw_lc_debug_interval                        10
> 
> So that's not what I meant, but I like it if we're going this way.
> 
> >   mds                              debug_mds                                    20/20
> >   mds                              debug_mgrc                                   20/20
> >   osd                              bluestore_block_create                       true
> >   osd                              bluestore_block_db_create                    true
> >   osd                              debug_bluestore                              30/30
> >   osd          host:gnit/class:hdd debug_bluestore                              20/20
> >   osd          host:gnit/class:ssd debug_bluestore                              20/20
> >     osd.0      host:gnit/class:ssd debug_bluestore                              21/21
> >
> > I'm not sure sorting by the option name would work well here since you'd
> > have, say, all of the debug_* options grouped together but applying to
> > different things.  The idea was to easily see what the osd configs are,
> > similar to what you get when looking at the old ini file.  And then also
> > see any specializations per daemon below it.
> 
> 
> Here's (a bad manually-typed illustration of) what I was suggesting:
> 
> OPTION                                       WHO            MASK
>          VALUE
> log_file                                          client
>                       /tmp/ceph-asok.A5CIZs/$name.$pid.asok
>                                                   mds
>                    /tmp/ceph-asok.A5CIZs/mds.$id.$pid.asok
> 
>    host:gnit
> /tmp/ceph-asok.special_gnit/mds.$id.$pid.asok
> bluestore_block_create               osd
>           true
> bluestore_block_db_create               osd
>           true
> debug_bluestore                          osd
> host:gnit/class:hdd 20/20
> 
> host:gnit/class:ssd 20/20
>                                                      osd.0
> host:gnit/class:ssd 21/21
> debug_filestore                            osd
>                  10/10
> 
> So this way the options which have different settings can be visually
> identified; and the same for masks versus daemon-type. (Although I'm
> not sure which order we want those columns to go in.)

That was pretty mangled, but I think see what you're after: grouping by 
config option, then enumerating all the various values for it.

I'm still partial to the group-by-section view.  I think it will be more 
helpful to easily grok what options apply to thing x (or things of type x) 
than to see how a single option varies across things of different types 
(e.g., who cares how osd's debug_ms compares to mds's debug_ms?).  Any 
other opinions?

If we really want both we could do 'ceph config dump-by-*' with the 
different sorting...

sage
--8323329-44371974-1515186037=:24931--
