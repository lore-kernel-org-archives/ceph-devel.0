From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v2 2/2] ceph: allow rename operation under different quota realms
Date: Wed, 8 Apr 2020 11:10:34 +0800
Message-ID: <CAAM7YAmpDKu_WuroNxZ2y+Po8_oT59Bi4_FOY1LD1ttOO0UDgQ@mail.gmail.com>
References: <20200407103020.22588-1-lhenriques@suse.com> <20200407103020.22588-3-lhenriques@suse.com>
 <e32db4ef5a0ae4e2002a3d957491c88e49daa5bb.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e32db4ef5a0ae4e2002a3d957491c88e49daa5bb.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, Zheng Yan <zyan@redhat.com>, Frank Schilder <frans@dtu.dk>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Apr 8, 2020 at 7:00 AM Jeff Layton <jlayton@kernel.org> wrote:

>
> Somewhat idle curiosity, but what happens with hardlinked files where
> one dentry is in one quota domain and another is in a different one?
> Does it stay in the old quotarealm?
>
> In any case, this is likely fine as non-hardlinked files are the
> pessimal case anyway.

rstat only tracks primary dentry.  inode is in the quota realm where
its primary linkage is in.
