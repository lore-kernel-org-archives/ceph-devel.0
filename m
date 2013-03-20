From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 04/39] mds: make sure table request id unique
Date: Wed, 20 Mar 2013 11:31:23 -0700
Message-ID: <971E9C644F3C4AD9A4BFA042FC238F34@inktank.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
 <1363531902-24909-5-git-send-email-zheng.z.yan@intel.com>
 <C7E493EEAA91442B9BD120B881E4638F@inktank.com>
 <51494EF6.6040607@intel.com>
 <alpine.DEB.2.00.1303192309380.11428@cobra.newdream.net>
 <51495BEC.9000802@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:39425 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab3CTSb0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 14:31:26 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp2so1570821pbb.34
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 11:31:26 -0700 (PDT)
In-Reply-To: <51495BEC.9000802@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday, March 19, 2013 at 11:49 PM, Yan, Zheng wrote:
> On 03/20/2013 02:15 PM, Sage Weil wrote:
> > On Wed, 20 Mar 2013, Yan, Zheng wrote:
> > > On 03/20/2013 07:09 AM, Greg Farnum wrote:
> > > > Hmm, this is definitely narrowing the race (probably enough to =
never hit it), but it's not actually eliminating it (if the restart hap=
pens after 4 billion requests?). More importantly this kind of symptom =
makes me worry that we might be papering over more serious issues with =
colliding states in the Table on restart.
> > > > I don't have the MDSTable semantics in my head so I'll need to =
look into this later unless somebody else volunteers to do so?
> > > =20
> > > =20
> > > =20
> > > Not just 4 billion requests, MDS restart has several stage, mdsma=
p epoch =20
> > > increases for each stage. I don't think there are any more collid=
ing =20
> > > states in the table. The table client/server use two phase commit=
=2E it's =20
> > > similar to client request that involves multiple MDS. the reqid i=
s =20
> > > analogy to client request id. The difference is client request ID=
 is =20
> > > unique because new client always get an unique session id.
> > =20
> > =20
> > =20
> > Each time a tid is consumed (at least for an update) it is journale=
d in =20
> > the EMetaBlob::table_tids list, right? So we could actually take a =
max =20
> > from journal replay and pick up where we left off? That seems like =
the =20
> > cleanest.
> > =20
> > I'm not too worried about 2^32 tids, I guess, but it would be nicer=
 to =20
> > avoid that possibility.
> =20
> =20
> =20
> Can we re-use the client request ID as table client request ID ?
> =20
> Regards
> Yan, Zheng

Not sure what you're referring to here =E2=80=94 do you mean the ID of =
the filesystem client request which prompted the update? I don't think =
that would work as client requests actually require two parts to be uni=
que (the client GUID and the request seq number), and I'm pretty sure a=
 single client request can spawn multiple Table updates.

As I look over this more, it sure looks to me as if the effect of the c=
ode we have (when non-broken) is to rollback every non-committed reques=
t by an MDS which restarted =E2=80=94 the only time it can handle the T=
ableServer's "agree" with a different response is if the MDS was incorr=
ectly marked out by the map. Am I parsing this correctly, Sage? Given t=
hat, and without having looked at the code more broadly, I think we wan=
t to add some sort of implicit or explicit handshake letting each of th=
em know if the MDS actually disappeared. We use the process/address non=
ce to accomplish this in other places=E2=80=A6
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
