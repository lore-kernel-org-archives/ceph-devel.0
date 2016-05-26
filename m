From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [GIT PULL] Ceph updates for 4.7-rc1
Date: Thu, 26 May 2016 21:10:11 +0100
Message-ID: <20160526201011.GM14480@ZenIV.linux.org.uk>
References: <alpine.DEB.2.11.1605261035390.6221@cpach.fuggernut.com>
 <CA+55aFz=U2rdLDOm=wHmS2UkmFqtx+PB--7K7B8uJtBza3dP4A@mail.gmail.com>
 <alpine.DEB.2.11.1605261446230.6221@cpach.fuggernut.com>
 <CA+55aFygBAq19UXECwQf_crUqNH4btTDircZJ=CctAHtFhnexw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFygBAq19UXECwQf_crUqNH4btTDircZJ=CctAHtFhnexw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sage Weil <sweil@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, May 26, 2016 at 12:54:27PM -0700, Linus Torvalds wrote:

> Having entirely new pull requests show up that haven't even been on my
> radar because they weren't in linux-next is annoying.

How about the things like followups to earlier merges?  I've got in
#for-linus
    update D/f/directory-locking
    add down_write_killable_nested()
    restore killability of old mutex_lock_killable(&inode->i_mutex) users

The first one probably should've been in the work.lookups merge, but
the last two clearly depend upon down_write_killable() having been already
merged...
