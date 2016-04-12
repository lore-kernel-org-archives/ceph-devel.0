From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Wed, 13 Apr 2016 01:12:43 +0200
Message-ID: <591AEC08-0FDE-4E65-9E6E-17441BB9F2D6@schermer.cz>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com> <4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz> <alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com> <8CF37229-17C6-4E49-A623-FB8933631F60@schermer.cz> <alpine.DEB.2.11.1604121525020.29593@cpach.fuggernut.com> <2CBEF339-052C-42D8-A6EA-5BA9C5B8DE9F@schermer.cz> <alpine.DEB.2.11.1604121639590.29593@cpach.fuggernut.com> <362740c3.9Ro.9Gf.hg.1qX1VyMOaE@mailjet.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33773 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030410AbcDLXMr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 19:12:47 -0400
Received: by mail-wm0-f46.google.com with SMTP id f198so206317310wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2016 16:12:46 -0700 (PDT)
In-Reply-To: <362740c3.9Ro.9Gf.hg.1qX1VyMOaE@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com

I apologise, I probably should have dialed down a bit.
I'd like to personally apologise to Sage, for being so patient with my ranting.

To be clear: We are so lucky to have Ceph. It was something we sorely needed and for the right price (free).
It's was a dream come true to cloud providers - and it still is.

However, working with it in production, spending much time getting to know how ceph works, what it does, and also seeing how and where it fails prompted my interest in where it's going, because big public clouds are one thing, traditional SMB/Small enterprise needs are another and that's where I feel it fails hard. So I tried prodding here on ML, watched performance talks (which, frankly, reinforced my confirmation bias) and hoped to see some hint of it getting bette. That for me equals simpler, faster, not reinventing the wheel. I truly don't see that and it makes me sad.

You are talking about the big picture - Ceph for storing anything, new architecture - and it sounds cool. Given enough money and time it can materialise, I won't elaborate on that. I just hope you don't forget about the measly RBD users like me (I'd guesstimate a silent 90%+ majority, but no idea, hopefully the product manager has a better one) who are frustrated from the current design. I'd like to think I represent those users who used to solve HA with DRBD 10 years ago, who had to battle NFS shares with rsync and inotify scripts, who were the only people on-call every morning at 3AM when logrotate killed their IO, all while having to work with rotting hardware and no budget. We are still out there and there's nothing for us - RBD is not as fast, simple or reliable as DRBD, filesystem is
  not as simple nor as fast as rsync, scrubbing still wakes us at 3AM...

I'd very much like Ceph to be my storage system of choice in the future again, which is why I am so vocal with my opinions, and maybe truly selfish with my needs. I have not yet been convinced of the bright future, and -  being the sceptical^Wcynical monster I turned into - I expect everything which makes my spidey sense tingle to fail, as it usually does. But that's called confirmation bias, which can make my whole point moot I guess :)

Jan 




> On 12 Apr 2016, at 23:08, Nick Fisk <nick@fisk.me.uk> wrote:
> 
> Jan,
> 
> I would like to echo Sage's response here. It seems you only want a subset
> of what Ceph offers, whereas RADOS is designed to offer a whole lot more,
> which requires a lot more intelligence at the lower levels.
> 
> I must say I have found your attitude to both Sage and the Ceph project as a
> whole over the last few emails quite disrespectful. I spend a lot of my time
> trying to sell the benefits of open source, which centre on the openness of
> the idea/code and not around the fact that you can get it for free. One of
> the things that I like about open source is the constructive, albeit
> sometimes abrupt, constructive criticism that results in a better product.
> Simply shouting Ceph is slow and it's because dev's don't understand
> filesystems is not constructive.
> 
> I've just come back from an expo at ExCel London where many providers are
> passionately talking about Ceph. There seems to be a lot of big money
> sloshing about for something that is inherently "wrong"
> 
> Sage and the core Ceph team seem like  very clever people to me and I trust
> that over the years of development, that if they have decided that standard
> FS's are not the ideal backing store for Ceph, that this is probably correct
> decision. However I am also aware that the human condition "Can't see the
> wood for the trees" is everywhere and I'm sure if you have any clever
> insights into filesystem behaviour, the Ceph Dev team would be more than
> open to suggestions.
> 
> Personally I wish I could contribute more to the project as I feel that I
> (any my company) get more from Ceph than we put in, but it strikes a nerve
> when there is such negative criticism for what effectively is a free
> product.
> 
> Yes, I also suffer from the problem of slow sync writes, but the benefit of
> being able to shift 1U servers around a Rack/DC compared to a SAS tethered
> 4U jbod somewhat outweighs that as well as several other advanatages. A new
> cluster that we are deploying has several hardware choices which go a long
> way to improve this performance as well. Coupled with the coming Bluestore,
> the future looks bright.
> 
>> -----Original Message-----
>> From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf Of
>> Sage Weil
>> Sent: 12 April 2016 21:48
>> To: Jan Schermer <jan@schermer.cz>
>> Cc: ceph-devel <ceph-devel@vger.kernel.org>; ceph-users <ceph-
>> users@ceph.com>; ceph-maintainers@ceph.com
>> Subject: Re: [ceph-users] Deprecating ext4 support
>> 
>> On Tue, 12 Apr 2016, Jan Schermer wrote:
>>> Still the answer to most of your points from me is "but who needs that?"
>>> Who needs to have exactly the same data in two separate objects
>>> (replicas)? Ceph needs it because "consistency"?, but the app (VM
>>> filesystem) is fine with whatever version because the flush didn't
>>> happen (if it did the contents would be the same).
>> 
>> If you want replicated VM store that isn't picky about consistency, try
>> Sheepdog.  Or your mdraid over iSCSI proposal.
>> 
>> We care about these things because VMs are just one of many users of
>> rados, and because even if we could get away with being sloppy in some (or
>> even most) cases with VMs, we need the strong consistency to build other
>> features people want, like RBD journaling for multi-site async
> replication.
>> 
>> Then there's the CephFS MDS, RGW, and a pile of out-of-tree users that
>> chose rados for a reason.
>> 
>> And we want to make sense of an inconsistency when we find one on scrub.
>> (Does it mean the disk is returning bad data, or we just crashed during a
> write
>> a while back?)
>> 
>> ...
>> 
>> Cheers-
>> sage
>> 
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 

