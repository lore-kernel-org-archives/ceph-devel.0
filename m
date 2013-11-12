From: Malcolm Haak <malcolm@sgi.com>
Subject: Re: HSM
Date: Tue, 12 Nov 2013 10:57:55 +1000
Message-ID: <52817D13.1070004@sgi.com>
References: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>	<528013F3.1010300@sgi.com>	<CAGd4Wr1qW-8rqF9EmpVc=-220rV6xnjFj2s6PT_UbhyPRpVX9Q@mail.gmail.com> <CAPYLRzjuhBAgTT2SPo+s5RkY32zT6ue-na_LzGY-9WKhscaL_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3.sgi.com ([192.48.152.1]:51399 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754065Ab3KLA6C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Nov 2013 19:58:02 -0500
In-Reply-To: <CAPYLRzjuhBAgTT2SPo+s5RkY32zT6ue-na_LzGY-9WKhscaL_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, John Spray <john.spray@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Gregory,


On 12/11/13 10:13, Gregory Farnum wrote:
> On Mon, Nov 11, 2013 at 3:04 AM, John Spray <john.spray@inktank.com> wrote:
>> This is a really useful summary from Malcolm.
>>
>> In addition to the coordinator/copytool interface, there is the question of
>> where the policy engine gets its data from.  Lustre has the MDS changelog,
>> which Robinhood uses to replicate metadata into its MySQL database with all
>> the indices that it wants.
>
>> On Sun, Nov 10, 2013 at 11:17 PM, Malcolm Haak <malcolm@sgi.com> wrote:
>>> So there aren't really any hooks in that exports are triggered by the policy engine after a scan of the metadata, and the recalls are triggered when caps are requested on offline files
>
> Wait, is the HSM using a changelog or is it just scanning the full
> filesystem tree? Scanning the whole tree seems awfully expensive.

While I can't speak at length about the LustreHSM, it may just use 
incremental updates to its SQL database via metadata logs, I do know 
that filesystem scans are done regularly in other HSM solutions. I also 
know that the scan is multi-threaded and when backed by decent disks 
does not take an excessive amount of time.

>
>> I don't know if CephFS MDS currently has a similar interface.
> Well, the MDSes each have their journal of course, but more than that
> we can stick whatever we want into the metadata and expose it via
> virtual xattrs or whatever else.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>>
>> John
>>
>>
>> On Sun, Nov 10, 2013 at 11:17 PM, Malcolm Haak <malcolm@sgi.com> wrote:
>>>
>>> Hi All,
>>>
>>> If you are talking specifically about Lustre HSM, its really an interface to add HSM functionality by leveraging existing HSM's (DMF for example)
>>>
>>> So with Lustre HSM you have a policy engine that triggers the migrations out of the filesystem. Rules are based around size, last accessed and target state (online, dual and offline).
>>>
>>> There is a 'coordinator' process involved here as well, it (from what I understand) runs on MDS nodes. It handles the interaction with the copytool. The copytool is provided by the HSM solution you are acutally using.
>>>
>>> For recalls when caps are aquired on the MDS for an exported file the resposible MSD contacts the coordinator, which in-turn uses the copytool to pull the required file out of the HSM.
>>>
>>> In the Lustre HSM, the objects that make up a file are all recalled and the file, not the objects, are handed to the HSM.
>>>
>>> For Lustre all it needs to keep track of is the current state of the file and the correct ID to reqest from the HSM. This is done inside the normal metadata storage.
>>>
>>> So there aren't really any hooks in that exports are triggered by the policy engine after a scan of the metadata, and the recalls are triggered when caps are requested on offline files. Then its just standard POSIX blocking until the file is available.
>>>
>>> Most of the state and ID stuff could be stored as XATTRS in cephfs. I'm not as sure how to do it for other things but as long as you could store some kind of extended metadata about whole objects, it could use the same interfaces as well.
>>>
>>> Hope that was acutually helpful and not just an obvious rehash...
>>>
>>> Regards
>>>
>>> Malcolm Haak
