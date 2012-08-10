From: =?iso-8859-1?Q?Fran=E7ois?= Charlier
	<francois.charlier@enovance.com>
Subject: Re: Puppet modules for Ceph
Date: Fri, 10 Aug 2012 18:21:12 +0200
Message-ID: <20120810162112.GG1882@potjevlesh.enovance.com>
References: <20120718135854.GI15546@potjevlesh.enovance.com>
 <5006CB25.105@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:4137 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437Ab2HJQVP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Aug 2012 12:21:15 -0400
Content-Disposition: inline
In-Reply-To: <5006CB25.105@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: puppet-users@googlegroups.com, ceph-devel@vger.kernel.org, puppet-openstack@puppetlabs.com

On Jul 18 09:41, Mark Nelson wrote:
> On 7/18/12 8:58 AM, Fran=C3=A7ois Charlier wrote:
> >Hi,
> >
> >I'm currently working on writing a Puppet module for Ceph.
> >
> >As after some research I found no existing module, I'll start from
> >scratch but I would be glad to hear from people who would already ha=
ve
> >started working or this or having any idea or pointers regarding thi=
s
> >subject.
> >
> >Thanks,
> >
> >[ By the way, I'm fc on #ceph ! ]
> >
>=20
> Hi Francois,
>=20
> That's great!  You might want to look at the chef work that has been
> done as a base to start from.  I'm not very familiar with what is in
> place, but Tommi or Dan may chime in later with more details.  Some
> of the folks from Mediawiki were actually just talking about puppet
> modules yesterday on the IRC channel so they may be interested in
> collaborating too.
>=20
> Thanks,
> Mark

Hi,

I'd like to keep you updated on the progress I made so far :

- the module is published on github: https://github.com/fcharlier/puppe=
t-ceph

- it's currently (only) able to install some MONs

- I hope to be able to add support for OSDs before next tuesday (becaus=
e
  I'm on vacation after that =E2=80=A6)

- I listed the necessary =E2=80=9Cmanual=E2=80=9D actions needed to ins=
tall a Ceph
  cluster (gathered from the Ceph Chef Cookbook and the mkcephfs script=
)
  on our wiki : https://labs.enovance.com/projects/puppet/wiki/Puppet-c=
eph
  but it might still contain some errors.

- I've decided to stick with exported resources to transfer information
  between the nodes.

Any comment or contribution would be much appreciated !

Sincerely,
--=20
=46ran=C3=A7ois Charlier                     Software Engineer
// eNovance labs               http://labs.enovance.com
// =E2=9C=89 francois.charlier@enovance.com =E2=98=8E +33 1 49 70 99 81
// fc on OFTC / fc___ on FreeNode
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
