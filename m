From: Jan Fajerski <jfajerski@suse.com>
Subject: Fwd: Re: exporting cluster status when cluster is unavailable
Date: Fri, 11 Aug 2017 11:04:03 +0200
Message-ID: <20170811090403.mwd4rne5q66wymbr@jf_suse_laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35214 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbdHKJEV (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 11 Aug 2017 05:04:21 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

----- Forwarded message from John Spray <jspray@redhat.com> -----

Date: Fri, 11 Aug 2017 09:49:03 +0100
From: John Spray <jspray@redhat.com>
To: Jan Fajerski <jfajerski@suse.com>
Subject: Re: exporting cluster status when cluster is unavailable

On Fri, Aug 11, 2017 at 9:28 AM, Jan Fajerski <jfajerski@suse.com> wrote:
> On Thu, Aug 10, 2017 at 11:26:54AM +0100, John Spray wrote:
>>
>> On Thu, Aug 10, 2017 at 10:52 AM, Jan Fajerski <jfajerski@suse.com> wrote:
>>>
>>> Hey John,
>>> one more thing on my mind, that I forgot to mention yesterday:
>>> Currently there is no good way to monitor the cluster state, when the
>>> cluster is unavailable (say 2/3 MONs are down). The ceph_exporter simply
>>> blocks, since it ever only makes on rados connection. The mgr plugin
>>> simply
>>> exports whatever is in its last mon_map (I assume). It'll just report a
>>> healthy cluster, since an unavailable cluster doesn't export a new
>>> mon_map.
>>> I'm not sure how to improve this, but I think since the mgr daemon is up
>>> it
>>> should export the proper cluster state. Any idea what would be "a good"
>>> or
>>> even "the proper" way to do this?
>>
>>
>> Yes, I looked into this a while back -- we need to add methods to
>> MonClient so that Mgr/MgrStandby can see if it really has a mon
>> session or not, and if it has no session for longer than a set period,
>> we would consider things to be bad.
>>
>> At that point, we have a few options (and perhaps some more I haven't
>> thought of...):
>> 1. Have the mgr daemon respawn (and thus go back to standby)
>> 2. Expose a boolean for python modules, so that they can continue to
>> operate, but flag to their user that the state they are showing is
>> stale (for example a UI would put an angry red banner across the top
>> of the screen or something)
>> 3.  Modify the health object that mgr is holding in memory, so that
>> modules automatically show that something is wrong even if they
>> neglect to check a flag like in 2.
>>
>> The cleanest thing to do is option 1, but it feels unfriendly -- for
>> something like a UI, it is much better to stay running and indicate a
>> problem to the user, rather than to just disappear.
>
> Agreed
>>
>>
>> Option 2 pushes the decision out to the python modules, but there is a
>> risk that modules simply forget to check the flag.
>>
>> Option 3 is the most "magic" for modules, but it feels kind of hacky
>> -- if we did this then many modules could/should still be doing an
>> explicit check, and the option 2 interface would be more appropriate
>> for that.
>>
>> My gut feeling is that we compromise and do option 2 and option 3.
>> Most "well behaved" modules would check the flag from option 2, and do
>> whatever makes sense for their case, but any module that didn't check
>> the flag would still hit the magic health check in option 3.
>
> This sounds good to me.
> What I had in mind was to add an optional argument to the mgr accessor
> methods exposed to plugins. Lets call it 'check_connection' (though I don't
> like it) and if true (maybe by default) the mgr daemon would check its mon
> session and return {} (or some such) if the session has dropped. If false
> the method would just return whatever copy the mgr has in memory.
> This kinda inverts your option 2. I can't however come up with a clear
> benefit of this and I might miss a big downside due to my ignorance of the
> mgr code.

Thinking of the python code for restful/dashboard, it would be easier
for the python side to handle a simple "is_connected" function,
because they could call that at the start of every request (probably
in a python decorator method or similar) and insert the result into
the response.

Once we have that flag, we can still return stale data (no need to
squash it to {}) -- that way a dashboard user can see their front page
stats, but with some bright indicator that this is stale data.  We
should leave it up to the modules whether they choose to return stale
data or to return no data.

I imagine that for things like the status and dashboard modules, we
would probably return stale data with a warning, whereas for things
like the restful module and prometheus module we would stop returning
any data.  We could broaden this discussion to ceph-devel to see what
others think (feel free to forward my mail)

John

>
>>
>> John
>>
>>> Best,
>>> Jan
>>>
>>> --
>>> Jan Fajerski
>>> Engineer Enterprise Storage
>>> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
>>> HRB 21284 (AG Nürnberg)
>>
>>
>
> --
> Jan Fajerski
> Engineer Enterprise Storage
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
> HRB 21284 (AG Nürnberg)


----- End forwarded message -----

-- 
Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
