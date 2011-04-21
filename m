From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: long object names
Date: Thu, 21 Apr 2011 14:23:08 -0700
Message-ID: <BANLkTikVQcMKsR1WY8uBQOk1KQ+tO+ezXA@mail.gmail.com>
References: <Pine.LNX.4.64.1104202117520.14154@cobra.newdream.net>
	<20110421185606.GC9431@dreamer>
	<BANLkTi=SOKMdSZu3B_+6TS_8-tSJDeu98g@mail.gmail.com>
	<20110421193240.GA26545@dreamer>
	<99672323C62444DFA181A0659E4D37FC@gmail.com>
	<BANLkTimvdNXA+F6sTS0HqkdUqE1uqFNkJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36866 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab1DUVXJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 17:23:09 -0400
Received: by iwn34 with SMTP id 34so98741iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2011 14:23:09 -0700 (PDT)
In-Reply-To: <BANLkTimvdNXA+F6sTS0HqkdUqE1uqFNkJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Thu, Apr 21, 2011 at 2:09 PM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> On Thu, Apr 21, 2011 at 1:03 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> I really don't see how pushing the naming complexity into the local filesystem,
>> where it adds lots of otherwise-useless inodes and dentries, is going to help us.
>
> Here is a quick summary of how the TV's proposal would help us.
> 1. it avoids collisions entirely
> 2. You don't ever have do an extra xattr lookup, no matter how short
> or long the object name is.

Yeah, but you read more directories. Note that btrfs stores the xattrs
on the directories, so reading those xattrs will have a lower IO
impact than traversing directories recursively.

>
> My add-on proposal helps us:
> 3. get reasonable prefix search performance (with those supposedly
> "useless" dentries)
>
>> I like what Yehuda has here for its relative simplicity -- though I think we should just up
>> the hash size enough that we don't need to handle collisions,
>
> Personally, I think the xattr proposal is more complex. I guess that
> is a matter of taste.
>
> No matter how big your hash table will be, there are still collisions!
> That is the nature of hashing. And since the code is open source, it's
> pretty easy for an attacker to read the source and then create two
> objects whose names collide.

Sure there will be, and the code should handle it. With a good hashing
scheme having a collision will be pretty rare.

>
> So far, the only disadvantage that has been pointed out to TV's scheme
> is that it creates extra dentries. But those extra dentries only
> affect long object names, not the ones that (for example) the Ceph FS
> creates. Also, when long object names occur in S3, they don't tend to
> come out of the blue. They come about because the organization has a
> sort of directory structure like this:
>
> foocorp/business_data/business_reports/year_2008/input/foo
> foocorp/business_data/business_reports/year_2008/input/bar
>
> Of course we "know" that there are no such things as directories in
> S3. But people like to structure their object names as if there were.
> In cases like that, TV's scheme only incurs the cost of creating the
> extra dentries once per long prefix.
>
As I said above, for most cases reading xattrs should be more efficient.


Yehuda
