From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 04/39] mds: make sure table request id unique
Date: Thu, 21 Mar 2013 15:03:47 -0700
Message-ID: <CAPYLRzhrH-=9itgY95XuE+uP54b4GxqVstRtmmW9_Qn1C3dHXw@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-5-git-send-email-zheng.z.yan@intel.com>
	<C7E493EEAA91442B9BD120B881E4638F@inktank.com>
	<51494EF6.6040607@intel.com>
	<alpine.DEB.2.00.1303192309380.11428@cobra.newdream.net>
	<51495BEC.9000802@intel.com>
	<971E9C644F3C4AD9A4BFA042FC238F34@inktank.com>
	<514ABFC6.3080100@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:39095 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068Ab3CUWDs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 18:03:48 -0400
Received: by mail-qc0-f173.google.com with SMTP id b12so740869qca.32
        for <ceph-devel@vger.kernel.org>; Thu, 21 Mar 2013 15:03:47 -0700 (PDT)
In-Reply-To: <514ABFC6.3080100@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 21, 2013 at 1:07 AM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> On 03/21/2013 02:31 AM, Greg Farnum wrote:
>> On Tuesday, March 19, 2013 at 11:49 PM, Yan, Zheng wrote:
>>> On 03/20/2013 02:15 PM, Sage Weil wrote:
>>>> On Wed, 20 Mar 2013, Yan, Zheng wrote:
>>>>> On 03/20/2013 07:09 AM, Greg Farnum wrote:
>>>>>> Hmm, this is definitely narrowing the race (probably enough to n=
ever hit it), but it's not actually eliminating it (if the restart happ=
ens after 4 billion requests?). More importantly this kind of symptom m=
akes me worry that we might be papering over more serious issues with c=
olliding states in the Table on restart.
>>>>>> I don't have the MDSTable semantics in my head so I'll need to l=
ook into this later unless somebody else volunteers to do so?
>>>>>
>>>>>
>>>>>
>>>>> Not just 4 billion requests, MDS restart has several stage, mdsma=
p epoch
>>>>> increases for each stage. I don't think there are any more collid=
ing
>>>>> states in the table. The table client/server use two phase commit=
=2E it's
>>>>> similar to client request that involves multiple MDS. the reqid i=
s
>>>>> analogy to client request id. The difference is client request ID=
 is
>>>>> unique because new client always get an unique session id.
>>>>
>>>>
>>>>
>>>> Each time a tid is consumed (at least for an update) it is journal=
ed in
>>>> the EMetaBlob::table_tids list, right? So we could actually take a=
 max
>>>> from journal replay and pick up where we left off? That seems like=
 the
>>>> cleanest.
>>>>
>>>> I'm not too worried about 2^32 tids, I guess, but it would be nice=
r to
>>>> avoid that possibility.
>>>
>>>
>>>
>>> Can we re-use the client request ID as table client request ID ?
>>>
>>> Regards
>>> Yan, Zheng
>>
>> Not sure what you're referring to here =97 do you mean the ID of the=
 filesystem client request which prompted the update? I don't think tha=
t would work as client requests actually require two parts to be unique=
 (the client GUID and the request seq number), and I'm pretty sure a si=
ngle client request can spawn multiple Table updates.
>>
>
> You are right, client request ID does not work.
>
>> As I look over this more, it sure looks to me as if the effect of th=
e code we have (when non-broken) is to rollback every non-committed req=
uest by an MDS which restarted =97 the only time it can handle the Tabl=
eServer's "agree" with a different response is if the MDS was incorrect=
ly marked out by the map. Am I parsing this correctly, Sage? Given that=
, and without having looked at the code more broadly, I think we want t=
o add some sort of implicit or explicit handshake letting each of them =
know if the MDS actually disappeared. We use the process/address nonce =
to accomplish this in other places=85
>> -Greg
>>
>
> The table server sends 'agree' message to table client after a 'prepa=
re entry' is safely logged. The table server re-sends 'agree' message i=
n two cases, one is the table client restarts, another is the table ser=
ver itself restarts.
> The purpose of re-sending 'agree' message is to check if the table cl=
ient still wants to keep the update preparation. (The table client migh=
t crash before submitting the update). The purpose of reqid is associat=
e table update
> preparation request with the server's 'agree' reply message. The prob=
lem here is that the table client does not make sure reqid unique betwe=
en restarts. If you feel 2^32 reqids are still enough, set the reqid to=
 a randomized 64bit
> value should be safe enough.

Right. I'd like to somehow mark those reqid's so that we can tell when
they come from a different incarnation of the MDS TableClient daemon.
One way is via some piece of random data that will probably
distinguish them, although if we have something which we can know is
different that would be preferable. I think we can work something out
of the startup session data each MDS does with the monitors, but I'm
not sure I can check any time soon; I have a number of other things to
get to now that I've gotten through (the first round on) this series.

Thanks for all the patches, by the way. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
