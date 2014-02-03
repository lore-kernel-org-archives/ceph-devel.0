From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] ceph: fix posix ACL hooks
Date: Mon, 3 Feb 2014 13:44:22 -0800
Message-ID: <CA+55aFyKN47V56oksujoojdV_uhoFYJxURg3RNHXbLFSqqDnGA@mail.gmail.com>
References: <CALFYKtDCNWK+9m5m3P01dcxOOV7iHFeNaOH=Q=6Pffuo8gmrMQ@mail.gmail.com>
	<1391013467-7598-1-git-send-email-ilya.dryomov@inktank.com>
	<CA+55aFwTuBDHgQoTymr8OtE-+k=+pX0T_eb+fff0K+Pa3C-g-Q@mail.gmail.com>
	<20140130075421.GA10050@infradead.org>
	<CA+55aFxbVFpy8Y8P5fMCmmTSGbFxU9dTbOj9uTH+fKWGUzwgNg@mail.gmail.com>
	<20140203102943.GF11829@infradead.org>
	<CA+55aFytvTPdBsv6BwSomUGWXZ_tKP=BxaeJ7FXBft0JNnjBCQ@mail.gmail.com>
	<20140203211955.GY10323@ZenIV.linux.org.uk>
	<CA+55aFyfPVgGXn_hSBnnVyzWn4AbZQ40MPk_AoKB_6uC6LJqPg@mail.gmail.com>
	<20140203213926.GA10323@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140203213926.GA10323@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Sage Weil <sage@inktank.com>, Dave Jones <davej@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Guangliang Zhao <lucienchao@gmail.com>, Li Wang <li.wang@ubuntykylin.com>, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

On Mon, Feb 3, 2014 at 1:39 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> If we really have hardlinks, the result of permission check would better
> be a function of inode itself - as in, "if it gives different results
> for two pathnames reachable for the same user, we have a bug".

No. You're wrong.

EVEN ON A UNIX FILESYSTEM THE PATH IS MEANINGFUL.

Do this: create a hardlink in two different directories. Make the
*directory* permissions for one of the directories be something you
cannot traverse. Now try to check the permissions of the *same* inode
through those two paths. Notice how you get *different* results.

Really.

Now, imagine that you are doing the same thing over a network. On the
server, there may be a single inode for the file, but when the client
gives the server a pathname, the two pathnames to that single inode
ARE NOT EQUIVALENT.

And the fact is, filesystems with hardlinks and path-name-based
operations do exist. cifs with the unix extensions is one of them.

Al, face it, you're wrong this time.

                      Linus
