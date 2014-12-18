From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Ceph updates for 3.19-rc1
Date: Wed, 17 Dec 2014 18:54:55 -0800
Message-ID: <CA+55aFwf7znK=EFGbF6NN14mPuFL-1GjzZffNVU_+qj52oaKkg@mail.gmail.com>
References: <alpine.DEB.2.00.1412171520460.5263@cobra.newdream.net>
	<CAAM7YAk-izpgFZGBoSO7P1VMXLO5i4ezSrPM4E4f7eFCw=f+3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAk-izpgFZGBoSO7P1VMXLO5i4ezSrPM4E4f7eFCw=f+3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Dec 17, 2014 at 6:25 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> my commit "ceph: add inline data to pagecache"  incidentally adds
> fs/ceph/super.j.rej.  please remove it from your branch.  sorry for
> the inconvenience

I wish I hadn't pulled it so quickly, and could have fixed it up as
part of the merge commit, but I pushed a separate commit to remove it.

                 Linus
