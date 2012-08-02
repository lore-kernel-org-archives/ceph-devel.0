From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RADOSGW internals ?
Date: Thu, 2 Aug 2012 09:24:48 -0700
Message-ID: <CAC-hyiGVToKn14wJYhkBk4XghvdyD7gKJYjTyQhTgrD=GmyGHA@mail.gmail.com>
References: <CAF6-1L6Yu-eFnV0uytwNoYBj1W7=MGJvOHvEwve4fCXGQx==dA@mail.gmail.com>
	<CAC-hyiG0HvPG_cf0495z_0UnPLeKt475PfQMW+ao-e_3y0yyyA@mail.gmail.com>
	<CAF6-1L69+Q9KbXX=JZo8w2B-kVk8pg0kBEAqZtJZqx3bfXOEMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50647 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2HBQYu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 12:24:50 -0400
Received: by bkwj10 with SMTP id j10so4338045bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 09:24:48 -0700 (PDT)
In-Reply-To: <CAF6-1L69+Q9KbXX=JZo8w2B-kVk8pg0kBEAqZtJZqx3bfXOEMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 2, 2012 at 8:22 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>
>> Will need logs in order to say what happened exactly, if that's of any
>> interest. You removed some crucial data for the full operation of that
>> bucket. It may also be that some of the data was still cached so that
>> you were able to complete some operations but not the others.
>
> In this particular case, some rados object were lost, in particular
> the  .dir.NNNN.N file that described the bucket.
> I tried recreating an empty file in its place but that doesn't seem to
> be enough.

No, the bucket index needs to be initialized.

>
> As I said, they're test scenarios on test data. I expect this case to
> happen only on bucket that we mapped on low replication pools (size=1
> or 2) and I don't really care if even the entire bucket is lost
> (they're used for temporary data transfer between services), but I
> need to be able to return to a consistent state.
> Because in this case I'm stuck ( can't call create bucket again, it
> thinks it's done already. can't call delete on the bucket because it
> thinks it doesn't exist ... ).
>
> That's why I needed to know where every trace of a bucket can be so I
> can go and wipe it manually to recreate the bucket from scratch.
>
> The loss of rados objects related to S3 objects seems easier to fix:
> just rm all rados object for it (seems there can be several with
> special prefixes) and then remove it from the entries in the
> .dir.NNNN.N object. So it should be fairly easy to write a "fix"
> utility that just rescans all objects in a bucket and deletes the
> inconsistent ones.
>
>
>> the users bucket index itself is in .users.uid, where it is kept under
>> an object named <uid>.buckets.
>
> Ah yes, I see. Clearing it from there works.

One final bit of info that references the bucket is on the user
buckets index. You can try running radosgw-admin bucket unlink
--bucket=<bucket> --uid=<uid> if you need to remove that ref.

Yehuda
