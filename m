From: Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [PATCH] mark rbd requiring stable pages
Date: Wed, 21 Oct 2015 23:07:14 -0500
Message-ID: <562860F2.8070208@cs.wisc.edu>
References: <201510151850.48348.ronny.hegewald@online.de> <CAOi1vP_ZDHBfCDeH6gxCKRsqoGteWv+nn7EFTexf+qsUBMHvjA@mail.gmail.com> <CAOi1vP8nAfr1_dNmvhNspz6ANZo2onGExU7=-agKLNr5KPxrzw@mail.gmail.com> <CAOi1vP_0GoqXuHm5SjZHpS8g_mK_wFRs9t9_VE1N9JUMFvL3Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sabe.cs.wisc.edu ([128.105.6.20]:37685 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbbJVEkm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Oct 2015 00:40:42 -0400
In-Reply-To: <CAOi1vP_0GoqXuHm5SjZHpS8g_mK_wFRs9t9_VE1N9JUMFvL3Gw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Ronny Hegewald <ronny.hegewald@online.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

On 10/21/2015 03:57 PM, Ilya Dryomov wrote:
> On Wed, Oct 21, 2015 at 10:51 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> On Fri, Oct 16, 2015 at 1:09 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>> Hmm...  On the one hand, yes, we do compute CRCs, but that's optional,
>>> so enabling this unconditionally is probably too harsh.  OTOH we are
>>> talking to the network, which means all sorts of delays, retransmission
>>> issues, etc, so I wonder how exactly "unstable" pages behave when, say,
>>> added to an skb - you can't write anything to a page until networking
>>> is fully done with it and expect it to work.  It's particularly
>>> alarming that you've seen corruptions.
>>>
>>> Currently the only users of this flag are block integrity stuff and
>>> md-raid5, which makes me wonder what iscsi, nfs and others do in this
>>> area.  There's an old ticket on this topic somewhere on the tracker, so
>>> I'll need to research this.  Thanks for bringing this up!
>>
>> Hi Mike,
>>
>> I was hoping to grab you for a few minutes, but you weren't there...
>>
>> I spent a better part of today reading code and mailing lists on this
>> topic.  It is of course a bug that we use sendpage() which inlines
>> pages into an skb and do nothing to keep those pages stable.  We have
>> csums enabled by default, so setting BDI_CAP_STABLE_WRITES in the crc
>> case is an obvious fix.
>>
>> I looked at drbd and iscsi and I think iscsi could do the same - ditch
>> the fallback to sock_no_sendpage() in the datadgst_en case (and get rid
>> of iscsi_sw_tcp_conn::sendpage member while at it).  Using stable pages
>> rather than having a roll-your-own implementation which doesn't close
>> the race but only narrows it sounds like a win, unless copying through
>> sendmsg() is for some reason cheaper than stable-waiting?

Yeah, that is what I was saying on the call the other day, but the
reception was bad. We only have the sendmsg code path when digest are on
because that code came before stable pages. When stable pages were
created, it was on by default but did not cover all the cases, so we
left the code. It then handled most scenarios, but I just never got
around to removing old the code. However, it was set to off by default
so I left it and made this patch for iscsi to turn on stable pages:

[this patch only enabled stable pages when digests/crcs are on and dif
not remove the code yet]
https://groups.google.com/forum/#!topic/open-iscsi/n4jvWK7BPYM

I did not really like the layering so I have not posted it for inclusion.



>>
>> drbd still needs the non-zero-copy version for its async protocol for
>> when they free the pages before the NIC has chance to put them on the
>> wire.  md-raid5 it turns out has an option to essentially disable most
>> of its stripe cache and so it sets BDI_CAP_STABLE_WRITES to compensate
>> if that option is enabled.
>>
>> What I'm worried about is the !crc (!datadgst_en) case.  I'm failing to
>> convince myself that mucking with sendpage()ed pages while they sit in
>> the TCP queue (or anywhere in the networking stack, really), is safe -
>> there is nothing to prevent pages from being modified after sendpage()
>> returned and Ronny reports data corruptions that pretty much went away
>> with BDI_CAP_STABLE_WRITES set.  I may be, after prolonged staring at
>> this, starting to confuse fs with block, though.  How does that work in
>> iscsi land?

This is what I was trying to ask about in the call the other day. Where
is the corruption that Ronny was seeing. Was it checksum mismatches on
data being written, or is incorrect meta data being written, etc?

If we are just talking about if stable pages are not used, and someone
is re-writing data to a page after the page has already been submitted
to the block layer (I mean the page is on some bio which is on a request
which is on some request_queue scheduler list or basically anywhere in
the block layer), then I was saying this can occur with any block
driver. There is nothing that is preventing this from happening with a
FC driver or nvme or cciss or in dm or whatever. The app/user can
rewrite as late as when we are in the make_request_fn/request_fn.

I think I am misunderstanding your question because I thought this is
expected behavior, and there is nothing drivers can do if the app is not
doing a flush/sync between these types of write sequences.


>>
>> (There was/is also this [1] bug, which is kind of related and probably
>> worth looking into at some point later.  ceph shouldn't be that easily
>> affected - we've got state, but there is a ticket for it.)
>>
>> [1] http://www.spinics.net/lists/linux-nfs/msg34913.html
> 
> And now with Mike on the CC and a mention that at least one scenario of
> [1] got fixed in NFS by a6b31d18b02f ("SUNRPC: Fix a data corruption
> issue when retransmitting RPC calls").
> 

iSCSI handles timeouts/retries and sequence numbers/responses
differently so we are not affected. We go through some abort and
possibly reconnect process.

