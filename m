From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 04/39] mds: make sure table request id unique
Date: Thu, 21 Mar 2013 16:07:34 +0800
Message-ID: <514ABFC6.3080100@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-5-git-send-email-zheng.z.yan@intel.com> <C7E493EEAA91442B9BD120B881E4638F@inktank.com> <51494EF6.6040607@intel.com> <alpine.DEB.2.00.1303192309380.11428@cobra.newdream.net> <51495BEC.9000802@intel.com> <971E9C644F3C4AD9A4BFA042FC238F34@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53807 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575Ab3CUIHi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Mar 2013 04:07:38 -0400
In-Reply-To: <971E9C644F3C4AD9A4BFA042FC238F34@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 03/21/2013 02:31 AM, Greg Farnum wrote:
> On Tuesday, March 19, 2013 at 11:49 PM, Yan, Zheng wrote:
>> On 03/20/2013 02:15 PM, Sage Weil wrote:
>>> On Wed, 20 Mar 2013, Yan, Zheng wrote:
>>>> On 03/20/2013 07:09 AM, Greg Farnum wrote:
>>>>> Hmm, this is definitely narrowing the race (probably enough to ne=
ver hit it), but it's not actually eliminating it (if the restart happe=
ns after 4 billion requests?). More importantly this kind of symptom ma=
kes me worry that we might be papering over more serious issues with co=
lliding states in the Table on restart.
>>>>> I don't have the MDSTable semantics in my head so I'll need to lo=
ok into this later unless somebody else volunteers to do so?
>>>> =20
>>>> =20
>>>> =20
>>>> Not just 4 billion requests, MDS restart has several stage, mdsmap=
 epoch =20
>>>> increases for each stage. I don't think there are any more collidi=
ng =20
>>>> states in the table. The table client/server use two phase commit.=
 it's =20
>>>> similar to client request that involves multiple MDS. the reqid is=
 =20
>>>> analogy to client request id. The difference is client request ID =
is =20
>>>> unique because new client always get an unique session id.
>>> =20
>>> =20
>>> =20
>>> Each time a tid is consumed (at least for an update) it is journale=
d in =20
>>> the EMetaBlob::table_tids list, right? So we could actually take a =
max =20
>>> from journal replay and pick up where we left off? That seems like =
the =20
>>> cleanest.
>>> =20
>>> I'm not too worried about 2^32 tids, I guess, but it would be nicer=
 to =20
>>> avoid that possibility.
>> =20
>> =20
>> =20
>> Can we re-use the client request ID as table client request ID ?
>> =20
>> Regards
>> Yan, Zheng
>=20
> Not sure what you're referring to here =E2=80=94 do you mean the ID o=
f the filesystem client request which prompted the update? I don't thin=
k that would work as client requests actually require two parts to be u=
nique (the client GUID and the request seq number), and I'm pretty sure=
 a single client request can spawn multiple Table updates.
>=20

You are right, client request ID does not work.

> As I look over this more, it sure looks to me as if the effect of the=
 code we have (when non-broken) is to rollback every non-committed requ=
est by an MDS which restarted =E2=80=94 the only time it can handle the=
 TableServer's "agree" with a different response is if the MDS was inco=
rrectly marked out by the map. Am I parsing this correctly, Sage? Given=
 that, and without having looked at the code more broadly, I think we w=
ant to add some sort of implicit or explicit handshake letting each of =
them know if the MDS actually disappeared. We use the process/address n=
once to accomplish this in other places=E2=80=A6
> -Greg
>=20

The table server sends 'agree' message to table client after a 'prepare=
 entry' is safely logged. The table server re-sends 'agree' message in =
two cases, one is the table client restarts, another is the table serve=
r itself restarts.
The purpose of re-sending 'agree' message is to check if the table clie=
nt still wants to keep the update preparation. (The table client might =
crash before submitting the update). The purpose of reqid is associate =
table update
preparation request with the server's 'agree' reply message. The proble=
m here is that the table client does not make sure reqid unique between=
 restarts. If you feel 2^32 reqids are still enough, set the reqid to a=
 randomized 64bit
value should be safe enough.

Thanks
Yan, Zheng
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
