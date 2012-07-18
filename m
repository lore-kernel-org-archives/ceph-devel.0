From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Puppet modules for Ceph
Date: Wed, 18 Jul 2012 10:09:22 -0700
Message-ID: <CADvuQRG5jot8yhmWWk8cNFUF7BkoHKbyL6fCVVF6GMu_DpPy7g@mail.gmail.com>
References: <20120718135854.GI15546@potjevlesh.enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33028 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab2GRRJn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 13:09:43 -0400
Received: by pbbrp8 with SMTP id rp8so2874708pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 10:09:43 -0700 (PDT)
In-Reply-To: <20120718135854.GI15546@potjevlesh.enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Fran=C3=A7ois_Charlier?= <francois.charlier@enovance.com>
Cc: puppet-users@googlgroups.com, ceph-devel@vger.kernel.org, puppet-openstack@puppetlabs.com

On Wed, Jul 18, 2012 at 6:58 AM, Fran=C3=A7ois Charlier
<francois.charlier@enovance.com> wrote:
> I'm currently working on writing a Puppet module for Ceph.
>
> As after some research I found no existing module, I'll start from
> scratch but I would be glad to hear from people who would already hav=
e
> started working or this or having any idea or pointers regarding this
> subject.

Hi. I don't remember anyone actively working on puppet modules for
Ceph. A quick search gives me just this:

http://git.sans.ethz.ch/?p=3Dpuppet-modules/ceph;a=3Dsummary

The Chef cookbook at https://github.com/ceph/ceph-cookbooks is
starting to get into a pretty good stage. It radically changes how we
do deployment and management, so I'd recommend you look at it in
detail, and don't imitate mkcephfs. We've been actively changing core
Ceph to make deployment and management simpler; I think the best proof
of that is that the cookbook is already shorter than the mkcephfs
shell script, and will probably just become a thinner layer in the
future. The Juju charms for Ceph are also adopting a model quite close
to what the Chef cookbook does.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
