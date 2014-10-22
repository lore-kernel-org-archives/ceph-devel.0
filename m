From: Sage Weil <sage@newdream.net>
Subject: Re: kerberos / AD requirements, blueprint
Date: Wed, 22 Oct 2014 10:08:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410220957210.29946@cobra.newdream.net>
References: <alpine.DEB.2.00.1410161253090.5588@cobra.newdream.net> <8667CC8E-D4CD-4BD2-8299-3341FEB848B6@cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38102 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbaJVRIT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Oct 2014 13:08:19 -0400
In-Reply-To: <8667CC8E-D4CD-4BD2-8299-3341FEB848B6@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "abartlet@catalyst.net.nz" <abartlet@catalyst.net.nz>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, Andrea Ieri <andrea.ieri@cern.ch>

On Wed, 22 Oct 2014, Dan Van Der Ster wrote:
> Hi Sage,
> 
> > On 16 Oct 2014, at 21:57, Sage Weil <sage@newdream.net> wrote:
> > 
> > I started to write up a blueprint for kerberos / LDAP / AD support:
> > 
> > 	https://wiki.ceph.com/Planning/Blueprints/Hammer/kerberos_authn%2C_AD_authn%2F%2Fauthz
> > 
> > In case it isn't clear from that document, I only sort of know what I'm 
> > talking about here.  (This is largely based on what I managed to retain 
> > from a conversation with Andrew, but I suspect I got some of it wrong.)
> > 
> > For anyone working in environments where kerberos is in use, I am *very* 
> > interested in hearing what your requirements are for your environment.  In 
> > particular, are you using AD or LDAP or something else?  How do you expect 
> > RBAC to work for you?
> 
> Let?s talk about requirements then. (Anyway, I?m not in any way a 
> kerberos expert and it is not 100% clear to me what you are trying to 
> achieve.)
> 
> Firstly, our environment is almost identical to that described by Marcus 
> (we use AD). For filesystems, our user communities are used to the way 
> OpenAFS works with kerberos. Generally, that means they use kinit && 
> aklog to authenticate and they understand (mostly) how to use AFS groups 
> and AFS ACLs for authz.

I take it that the kinit + aklog use-case is about a user authenticating 
their workstation to mount AFS?

Just to be clear, the user auth issues for fs access once things are 
mounted is still out of scope for the current effort.  But mounting itself 
means the client (host) has to authenticate against the cluster and that 
is probably in scope.

> Next I basically have a bunch of questions to clarify your goals. The 
> first part of your blueprint seems to be a convenient way to distribute 
> cephx keyrings. To prevent harvesting/reuse, would you intend those to 
> not be ?normal? cephx keyrings as such, but rather to be keyrings 
> encrypted by the mon/whatever and time limited?

It's not so much about distributing keyrings, and using the existing 
kerberos auth in place of cephx keys.  With just the first part, the 
workflow might go something like:

 - define client.user1 and its caps
    - add a property that specifies a kerberos user/domain to map to
    - but do not generate a cephx key
 - kinit user1
 - ceph -n client.user1 ...
    - would use kerberos ticket to authenticate as client.user1 on mon
 ...

> For authz, is this mechanism meant to be used for RADOS only, or also 
> for CephFS?

Initially I'm just concerned with RADOS authentication.  And the main 
use-case is cluster administration (ceph and rbd CLI commands).

Step 2 (authz) would be to tag the kerberos users with some metadata like 
'ceph rw' and map to a generic ceph user (say, client.krb-rw).  The caps 
would be defined once per role in ceph as opposed to once per user (which 
is an administrative headache).  Granting a new kerberos user readonly or 
readwrite access to the ceph/rbd CLI could then be done exclusively from 
AD (or whatever) infrastructure.

> If RADOS only, then as I understand it you could basically add the 
> current cephx capabilities (with pool granularity) to the proposed ceph 
> user db (perhaps scoped down to a few limited roles). I wouldn?t expect 
> to be able to manipulate ceph capabilities via some AD blob (due mostly 
> to my AD ignorance). I would probably expect to add our authorised ceph 
> users to an AD group, then keep that in sync with your ceph 
> user/role/capability db.

Yeah, that is probably the most sensible.  Perhaps the ceph role 
definition would be something like

[client.krb-rw]
	mon = allow rw
	osd = allow *
	mds = allow *
	krb5_group = ceph_rw

or something along those lines.

> If CephFS, then the problem I see is that the POSIX permissions/ACLs are 
> being evaluated only on the client side. Were you thinking to change 
> that, i.e. to add some notion of CephFS file-granular cephx 
> capabilities? We thought a little bit about this before:
>   
> https://wiki.ceph.com/Planning/Blueprints/%3CSIDEBOARD%3E/Strong_AuthN_and_AuthZ_for_CephFS 
> The basic idea was to have an MDS or other service that evaluates 
> permissions/ACLs on the server side then hands out an extra signed 
> capability to be used by the client for IOs with an OSD. It seems 
> heavyweight, however, so I?m not sure how this would perform in 
> practise.

Yeah, this is a whole other ball of wax that I'd prefer to ignore for the 
time being... :)

Thanks!
sage

