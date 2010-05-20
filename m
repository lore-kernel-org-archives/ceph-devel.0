From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for May 20 (ceph)
Date: Thu, 20 May 2010 12:52:32 -0700
Message-ID: <20100520125232.0341d995.randy.dunlap@oracle.com>
References: <20100520163042.9486e077.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100520163042.9486e077.sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Sage Weil <sage@newdream.net>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 20 May 2010 16:30:42 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> We are in the merge window again.  I remind you all not to add stuff for
> 2.6.36 to your linux-next trees until after 2.6.35-rc1.


when CONFIG_BLOCK is not enabled:

fs/ceph/messenger.c:732: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:740: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:740: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:740: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:743: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:744: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:793: error: implicit declaration of function 'bio_iovec_idx'
fs/ceph/messenger.c:793: warning : assignment makes pointer from integer without a cast
fs/ceph/messenger.c:794: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:795: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:798: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:1406: warning: initialization makes pointer from integer without a cast
fs/ceph/messenger.c:1413: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:1413: warning: type defaults to 'int' in declaration of '_min2'
fs/ceph/messenger.c:1413: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:1416: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:1416: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:1424: error: dereferencing pointer to incomplete type
fs/ceph/messenger.c:1429: error: dereferencing pointer to incomplete type

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
