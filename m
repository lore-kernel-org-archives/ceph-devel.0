From: Sage Weil <sage@newdream.net>
Subject: Re: crush devices class types
Date: Wed, 8 Mar 2017 14:39:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703081432150.1727@piezo.novalocal>
References: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org> <1971303930.7861.1485178720341@ox.pcextreme.nl> <alpine.DEB.2.11.1701231428190.3654@piezo.novalocal> <372c7fcb-8697-28ea-0d7c-1efc29fc21cf@dachary.org> <alpine.DEB.2.11.1702022047070.3654@piezo.novalocal>
 <2e591b25-3db2-2dd2-03af-2c1ef40292ac@dachary.org> <CALe9h7ds0PpqX-QJ0Usb-OLggPMCE2KF0tLurGfKFmms89nDiA@mail.gmail.com> <83ad191e-933f-83a4-c6d4-c831c1ac893f@dachary.org> <CALe9h7e-uOvQdO1GqNo6xpJ=QgoLyJ_ycgyP9c_Z_sXptHUJjg@mail.gmail.com>
 <8bf1e90e-20ca-e4e9-d3dd-3535b6a7d781@dachary.org> <CABZ+qqkNb8rAr27oKL3txJfY-OFjpF5vKXFCyRywEVvkzNXbgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1840731918-1488983963=:1727"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48168 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdCHOjY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 09:39:24 -0500
In-Reply-To: <CABZ+qqkNb8rAr27oKL3txJfY-OFjpF5vKXFCyRywEVvkzNXbgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Loic Dachary <loic@dachary.org>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1840731918-1488983963=:1727
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 8 Mar 2017, Dan van der Ster wrote:
> Hi Loic,
> 
> Did you already have a plan for how an operator would declare the
> device class of each OSD?
> Would this be a new --device-class option to ceph-disk prepare, which
> would perhaps create a device-class file in the root of the OSD's xfs
> dir?
> Then osd crush create-or-move in ceph-osd-prestart.sh would be a
> combination of ceph.conf's "crush location" and this per-OSD file.

Hmm we haven't talked about this part yet.  I see a few options...

1) explicit ceph-disk argument, recorded as a file in osd_data

2) osd can autodetect this based on the 'rotational' flag in sysfs.  The 
trick here, I think, is to come up with suitable defaults.  We might have 
NVMe, SATA/SAS SSDs, HDD, or a combination (with journal and data (and 
db) spread across multiple types).   Perhaps those could break down into 
classes like

	hdd
	ssd
	nvme
	hdd+ssd-journal
	hdd+nvme-jouranl
	hdd+ssd-db+nvme-jouranl

which is probably sufficient for most users.  And if the admin likes they 
can override.

- Then the osd adjusts device-class on startup, just like it does with the 
crush map position.  (Note that this will have no real effect until the 
CRUSH rule(s) are changed to use device class.)

- We'll need an 'osd crush set-device-class <osd.NNN> <class>' command.  
The only danger I see here is that if you set it to something other than  
what the OSD autodetects above, it'll get clobbered on the next OSD 
restart.  Maybe the autodetection *only* sets the device class if it isn't 
already set?

- We need to adjust the crush rule commands to allow a device class. 
Currently we have

osd crush rule create-erasure <name>     create crush rule <name> for erasure 
 {<profile>}                              coded pool created with <profile> (
                                          default default)
osd crush rule create-simple <name>      create crush rule <name> to start from 
 <root> <type> {firstn|indep}             <root>, replicate across buckets of 
                                          type <type>, using a choose mode of 
                                          <firstn|indep> (default firstn; indep 
                                          best for erasure pools)

...so we could add another optional arg at the end for the device class.

sage





> 
> Cheers, Dan
> 
> 
> 
> On Wed, Feb 15, 2017 at 1:14 PM, Loic Dachary <loic@dachary.org> wrote:
> > Hi John,
> >
> > Thanks for the discussion :-) I'll start implementing the proposal as described originally.
> >
> > Cheers
> >
> > On 02/15/2017 12:57 PM, John Spray wrote:
> >> On Fri, Feb 3, 2017 at 1:21 PM, Loic Dachary <loic@dachary.org> wrote:
> >>>
> >>>
> >>> On 02/03/2017 01:46 PM, John Spray wrote:
> >>>> On Fri, Feb 3, 2017 at 12:22 PM, Loic Dachary <loic@dachary.org> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> Reading Wido & John comments I thought of something, not sure if that's a good idea or not. Here it is anyway ;-)
> >>>>>
> >>>>> The device class problem we're trying to solve is one instance of a more general need to produce crush tables that implement a given use case. The SSD / HDD use case is so frequent that it would make sense to modify the crush format for this. But maybe we could instead implement that to be a crush table generator.
> >>>>>
> >>>>> Let say you want help to create the hierarchies to implement the ssd/hdd separation, you write your crushmap using the proposed syntax. But instead of feeding it directly to crushtool -c, you would do something like:
> >>>>>
> >>>>>    crushtool --plugin 'device-class' --transform < mycrushmap.txt | crushtool -c - -o mycrushmap
> >>>>>
> >>>>> The 'device-class' transformation documents the naming conventions so the user knows root will generate root_ssd and root_hdd. And the users can also check by themselves the generated crushmap.
> >>>>>
> >>>>> Cons:
> >>>>>
> >>>>> * the users need to be aware of the transformation step and be able to read and understand the generated result.
> >>>>> * it could look like it's not part of the standard way of doing things, that it's a hack.
> >>>>>
> >>>>> Pros:
> >>>>>
> >>>>> * it can inspire people to implement other crushmap transformation / generators (an alternative, simpler, syntax comes to mind ;-)
> >>>>> * it can be implemented using python to lower the barrier of entry
> >>>>>
> >>>>> I don't think it makes the implementation of the current proposal any simpler or more complex. Worst case scenario nobody write any plugin but that does not make this one plugin less useful.
> >>>>
> >>>> I think this is basically the alternative approach that Sam was
> >>>> suggesting during CDM: the idea of layering a new (perhaps very
> >>>> similar) syntax on top of the existing one, instead of extending the
> >>>> existing one directly.
> >>>
> >>> Ha nice, not such a stupid idea then :-) I'll try to defend it a little more below then. Please bear in mind that I'm not sure this is the way to go even though I'm writing as if I am.
> >>>
> >>>> The main argument against doing that was the complexity, not just of
> >>>> implementation but for users, who would now potentially have two
> >>>> separate sets of commands, one operating on the "high level" map
> >>>> (which would have a "myhost" object in it), and one operating on the
> >>>> native crush map (which would only have myhost~ssd, myhost~hdd
> >>>> entries, and would have no concept that a thing called myhost
> >>>> existed).
> >>>
> >>> As a user I'm not sure what is more complicated / confusing. If I'm an experienced Ceph user I'll think of this new syntax as a generator because I already know how crush works. I'll welcome the help and be relieved that I don't have to manually do that anymore. But having that as a native syntax may be a little unconfortable for me because I will want to verify the new syntax matches what I expect, which comes naturally if the transformation step is separate. I may even tweak it a little with an intermediate script to match one thing or two. If I'm a new Ceph user this is one more concept I need to learn: the device class. And to understand what it means, the documentation will have to explain that it creates an independant crush hierarchy for each device class, with weights that on
 ly take into account the devices of that given class. I will not be exonerated from understanding the transformation step and the syntactic sugar may even make that more complicated to get.
> >>>
> >>> If I understand correctly, the three would co-exist: host, host~ssd, host~hdd so that you can write a rule that takes from all devices.
> >>
> >> (Sorry this response is so late)
> >>
> >> I think the extra work is not so much in the formats, as it is
> >> exposing that syntax via all the commands that we have, and/or new
> >> commands.  We would either need two lots of commands, or we would need
> >> to pick one layer (the 'generator' or the native one) for the
> >> commands, and treat the other layer as a hidden thing.
> >>
> >> It's also not just the extra work of implementing the commands/syntax,
> >> it's the extra complexity that ends up being exposed to users.
> >>
> >>>
> >>>> As for implemetning other generators, the trouble with that is that
> >>>> the resulting conventions would be unknown to other tools, and to any
> >>>> commands built in to Ceph.
> >>>
> >>> Yes. But do we really want to insert the concept of "device class" in Ceph ? There are recurring complaints about manually creating the crushmap required to separate ssd from hdd. But is it inconvenient in any way that Ceph is otherwise unaware of this distinction ?
> >>
> >> Currently, if someone has done the manual stuff to set up SSD/HDD
> >> crush trees, any external tool has no way of knowing that two hosts
> >> (one ssd, one hdd) are actually the same host.  That's the key thing
> >> here for me -- the time saving during setup is a nice side effect, but
> >> the primary value of having a Ceph-defined way to do this is that
> >> every tool building on Ceph can rely on it.
> >>
> >>
> >>
> >>>> We *really* need a variant of "set noout"
> >>>> that operates on a crush subtree (typically a host), as it's the sane
> >>>> way to get people to temporarily mark some OSDs while they
> >>>> reboot/upgrade a host, but to implement that command we have to have
> >>>> an unambiguous way of identifying which buckets in the crush map
> >>>> belong to a host.  Whatever the convention is (myhost~ssd, myhost_ssd,
> >>>> whatever), it needs to be defined and built into Ceph in order to be
> >>>> interoperable.
> >>>
> >>> That goes back (above) to my understanding of Sage proposal (which I may have wrong ?) in which the host bucket still exists and still contains all devices regardless of their class.
> >>
> >> In Sage's proposal as I understand it, there's an underlying native
> >> crush map that uses today's format (i.e. clients need no upgrade),
> >> which is generated in response to either commands that edit the map,
> >> or the user inputting a modified map in the text format.  That
> >> conversion would follow pretty simple rules (assuming a host 'myhost'
> >> with ssd and hdd devices):
> >>  * On the way in, bucket 'myhost' generates 'myhost~ssd', 'myhost~hdd' buckets
> >>  * On the way out, buckets 'myhost~ssd', 'myhost~hdd' get merged into 'myhost'
> >>  * When running a CLI command, something targeting 'myhost' will
> >> target both 'myhost~hdd' and 'myhost~ssd'
> >>
> >> It's that last part that probably isn't captured properly by something
> >> external that does a syntax conversion during import/export.
> >>
> >> John
> >>
> >>> Cheers
> >>>
> >>>>
> >>>> John
> >>>>
> >>>>
> >>>>
> >>>>> Cheers
> >>>>>
> >>>>> On 02/02/2017 09:57 PM, Sage Weil wrote:
> >>>>>> Hi everyone,
> >>>>>>
> >>>>>> I made more updates to http://pad.ceph.com/p/crush-types after the CDM
> >>>>>> discussion yesterday:
> >>>>>>
> >>>>>> - consolidated notes into a single proposal
> >>>>>> - use otherwise illegal character (e.g., ~) as separater for generated
> >>>>>> buckets.  This avoids ambiguity with user-defined buckets.
> >>>>>> - class-id $class $id properties for each bucket.  This allows us to
> >>>>>> preserve the derivative bucket ids across a decompile->compile cycle so
> >>>>>> that data does not move (the bucket id is one of many inputs into crush's
> >>>>>> hash during placement).
> >>>>>> - simpler rule syntax:
> >>>>>>
> >>>>>>     rule ssd {
> >>>>>>             ruleset 1
> >>>>>>             step take default class ssd
> >>>>>>             step chooseleaf firstn 0 type host
> >>>>>>             step emit
> >>>>>>     }
> >>>>>>
> >>>>>> My rationale here is that we don't want to make this a separate 'step'
> >>>>>> call since steps map to underlying crush rule step ops, and this is a
> >>>>>> directive only to the compiler.  Making it an optional step argument seems
> >>>>>> like the cleanest way to do that.
> >>>>>>
> >>>>>> Any other comments before we kick this off?
> >>>>>>
> >>>>>> Thanks!
> >>>>>> sage
> >>>>>>
> >>>>>>
> >>>>>> On Mon, 23 Jan 2017, Loic Dachary wrote:
> >>>>>>
> >>>>>>> Hi Wido,
> >>>>>>>
> >>>>>>> Updated http://pad.ceph.com/p/crush-types with your proposal for the rule syntax
> >>>>>>>
> >>>>>>> Cheers
> >>>>>>>
> >>>>>>> On 01/23/2017 03:29 PM, Sage Weil wrote:
> >>>>>>>> On Mon, 23 Jan 2017, Wido den Hollander wrote:
> >>>>>>>>>> Op 22 januari 2017 om 17:44 schreef Loic Dachary <loic@dachary.org>:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Hi Sage,
> >>>>>>>>>>
> >>>>>>>>>> You proposed an improvement to the crush map to address different device types (SSD, HDD, etc.)[1]. When learning how to create a crush map, I was indeed confused by the tricks required to create SSD only pools. After years of practice it feels more natural :-)
> >>>>>>>>>>
> >>>>>>>>>> The source of my confusion was mostly because I had to use a hierarchical description to describe something that is not organized hierarchically. "The rack contains hosts that contain devices" is intuitive. "The rack contains hosts that contain ssd that contain devices" is counter intuitive. Changing:
> >>>>>>>>>>
> >>>>>>>>>>     # devices
> >>>>>>>>>>     device 0 osd.0
> >>>>>>>>>>     device 1 osd.1
> >>>>>>>>>>     device 2 osd.2
> >>>>>>>>>>     device 3 osd.3
> >>>>>>>>>>
> >>>>>>>>>> into:
> >>>>>>>>>>
> >>>>>>>>>>     # devices
> >>>>>>>>>>     device 0 osd.0 ssd
> >>>>>>>>>>     device 1 osd.1 ssd
> >>>>>>>>>>     device 2 osd.2 hdd
> >>>>>>>>>>     device 3 osd.3 hdd
> >>>>>>>>>>
> >>>>>>>>>> where ssd/hdd is the device class would be much better. However, using the device class like so:
> >>>>>>>>>>
> >>>>>>>>>>     rule ssd {
> >>>>>>>>>>             ruleset 1
> >>>>>>>>>>             type replicated
> >>>>>>>>>>             min_size 1
> >>>>>>>>>>             max_size 10
> >>>>>>>>>>             step take default:ssd
> >>>>>>>>>>             step chooseleaf firstn 0 type host
> >>>>>>>>>>             step emit
> >>>>>>>>>>     }
> >>>>>>>>>>
> >>>>>>>>>> looks arcane. Since the goal is to simplify the description for the first time user, maybe we could have something like:
> >>>>>>>>>>
> >>>>>>>>>>     rule ssd {
> >>>>>>>>>>             ruleset 1
> >>>>>>>>>>             type replicated
> >>>>>>>>>>             min_size 1
> >>>>>>>>>>             max_size 10
> >>>>>>>>>>             device class = ssd
> >>>>>>>>>
> >>>>>>>>> Would that be sane?
> >>>>>>>>>
> >>>>>>>>> Why not:
> >>>>>>>>>
> >>>>>>>>> step set-class ssd
> >>>>>>>>> step take default
> >>>>>>>>> step chooseleaf firstn 0 type host
> >>>>>>>>> step emit
> >>>>>>>>>
> >>>>>>>>> Since it's a 'step' you take, am I right?
> >>>>>>>>
> >>>>>>>> Good idea... a step is a cleaner way to extend the syntax!
> >>>>>>>>
> >>>>>>>> sage
> >>>>>>>> --
> >>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>>>>>> the body of a message to majordomo@vger.kernel.org
> >>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>>>>>
> >>>>>>>
> >>>>>>> --
> >>>>>>> Loïc Dachary, Artisan Logiciel Libre
> >>>>>>> --
> >>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>>>>> the body of a message to majordomo@vger.kernel.org
> >>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>>>>
> >>>>>
> >>>>> --
> >>>>> Loïc Dachary, Artisan Logiciel Libre
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>
> >>> --
> >>> Loïc Dachary, Artisan Logiciel Libre
> >>
> >
> > --
> > Loïc Dachary, Artisan Logiciel Libre
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1840731918-1488983963=:1727--
