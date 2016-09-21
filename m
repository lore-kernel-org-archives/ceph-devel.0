From: Jan Fajerski <jfajerski@suse.com>
Subject: Re: richacl packaging for cephfs
Date: Wed, 21 Sep 2016 14:46:54 +0200
Message-ID: <20160921124654.twnwrgtfywie6tyx@jf_suse_laptop>
References: <CALe9h7f_q9iGzTRYhXHKiNFfn2qKfc-UUh+eWJ_XqTh9YoqQWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44143 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbcIUMrB (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 21 Sep 2016 08:47:01 -0400
Content-Disposition: inline
In-Reply-To: <CALe9h7f_q9iGzTRYhXHKiNFfn2qKfc-UUh+eWJ_XqTh9YoqQWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, James Page <james.page@canonical.com>, Tim Serong <tserong@suse.com>, Ken Dreyer <kdreyer@redhat.com>

On Tue, Sep 20, 2016 at 03:57:04PM +0100, John Spray wrote:
> Hi all,
> 
> I was just taking an updated look at how we could proceed to get
> richacl support[1,2,3] built and tested in cephfs (probably for
> luminous).
> 
> The packages exist currently for Fedora.  For testing, we will need
> them for Ubuntu (probably just Xenial?), CentOS and RHEL (once there
> are RHEL nodes in the sepia lab).
> 
> I'm not very aware of ways forward for Ubuntu, but on the CentOS front
> it seems like we have at least a couple of possibilities:
>  * Build ourselves (using some branch of the fedora packaging?) on a
> Ceph gitbuilder/jenkins job and install from that repo in teuthology
> jobs
>  * Get packages into CentOS Storage SIG and point teuthology at
> external storage SIG repos during testing
> 
> I believe we could ask nicely for some help from the storage SIG to
> package richacl, but I'm not immediately sure if that's actually our
> preferred approach for consuming packages in our CI vs. self-building
> anything that's not in the distro.
> 
> Does anybody have thoughts on the best way to go?
> 
> Would also love to hear any thoughts about richacl  SUSE and Ubuntu
Hi John,
I would take over the maintenance for the richacl userland tools in opensuse.
As for the other necessary parts I'll get in touch with some other teams at
SUSE to see what they think.

Best,
Jan

> 
> John
> 
> 1. https://github.com/ceph/ceph/pull/6341
> 2. https://github.com/andreas-gruenbacher/richacl
> 3. http://pkgs.fedoraproject.org/cgit/rpms/richacl.git/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH
jfajerski@suse.com
