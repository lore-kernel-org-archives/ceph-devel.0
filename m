From: Wido den Hollander <wido@42on.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Fri, 16 Jan 2015 08:55:46 +0100
Message-ID: <54B8C402.9020301@42on.com>
References: <54B7D2D6.4020503@42on.com> <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com> <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net> <alpine.DEB.2.00.1501150942450.26676@cobra.newdream.net> <CAC6JEv-r2a6UOWOd8XKsn4armJU4iR76eYtG3kR4eGmKW6k++w@mail.gmail.com> <alpine.DEB.2.00.1501151004540.15918@cobra.newdream.net> <CAGd4Wr055nGU8D+pzN_bFhOkNVrNBZA1xZdfo80+Mu5Bddx+pg@mail.gmail.com> <alpine.DEB.2.00.1501151105050.15918@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:41253 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbbAPHzs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 16 Jan 2015 02:55:48 -0500
In-Reply-To: <alpine.DEB.2.00.1501151105050.15918@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, John Spray <john.spray@redhat.com>
Cc: Gregory Farnum <greg@gregs42.com>, Yehuda Sadeh <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 01/15/2015 08:07 PM, Sage Weil wrote:
> On Thu, 15 Jan 2015, John Spray wrote:
>> On Thu, Jan 15, 2015 at 6:07 PM, Sage Weil <sweil@redhat.com> wrote:
>>>> What would that buy us? Preventing injectargs on it would require mon
>>>> restarts, which is unfortunate ? and makes it sounds more like a
>>>> security feature than a safety blanket.
>>>
>>> I meant 'ceph tell mon.* injectargs ...' as distinct from 'ceph daemon ...
>>> config set', which requires access to the host.  But yeah, if we went to
>>> the effort to limit injectargs (maybe a blanket option that disables
>>> injectargs on mons?), it could double as a security feature.
>>>
>>> But whether it may also useful for security doesn't change whether it is a
>>> good safety blanket.  I like it because it's simple, easy to implement,
>>> and easy to disable for testing... :)
>>
>> The trouble with this is admin socket part is that any tool that
>> manages Ceph must use the admin socket interface as well as the normal
>> over-the-network command interface, and by extension must be able to
>> execute locally on a mon.  We would no longer have a comprehensive
>> remote management interface for the mon: management tools would have
>> to run some code locally too.
> 
> True.. if we make that option enabled by default.  If we it's off by 
> default them it's an opt-in layer of protection.  Most clusters don't have 
> ephemeral pools so I think lots of people would want this.
>  

If this is the easiest route I'm +1 for that way.

I'd turn it off right away on the clusters I manage. Pools don't change
that often and I simply want another safeguard against deleting them.

>> I think it's sufficient to require two API calls (set the flag or
>> config option, then do the delete) within the remote API, rather than
>> requiring that anyone driving the interface knows how to speak two
>> network protocols (usual mon remote command + SSH-to-asok).
> 
> Yeah...
> 
> sage
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
