From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] ceph: fix posix ACL hooks
Date: Mon, 3 Feb 2014 13:36:12 -0800
Message-ID: <20140203213612.GA15427@infradead.org>
References: <CALFYKtDCNWK+9m5m3P01dcxOOV7iHFeNaOH=Q=6Pffuo8gmrMQ@mail.gmail.com>
 <1391013467-7598-1-git-send-email-ilya.dryomov@inktank.com>
 <CA+55aFwTuBDHgQoTymr8OtE-+k=+pX0T_eb+fff0K+Pa3C-g-Q@mail.gmail.com>
 <20140130075421.GA10050@infradead.org>
 <CA+55aFxbVFpy8Y8P5fMCmmTSGbFxU9dTbOj9uTH+fKWGUzwgNg@mail.gmail.com>
 <20140203102943.GF11829@infradead.org>
 <CA+55aFytvTPdBsv6BwSomUGWXZ_tKP=BxaeJ7FXBft0JNnjBCQ@mail.gmail.com>
 <20140203211955.GY10323@ZenIV.linux.org.uk>
 <20140203212447.GA4843@infradead.org>
 <20140203213153.GZ10323@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140203213153.GZ10323@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Sage Weil <sage@inktank.com>, Dave Jones <davej@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Guangliang Zhao <lucienchao@gmail.com>, Li Wang <li.wang@ubuntykylin.com>, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

On Mon, Feb 03, 2014 at 09:31:53PM +0000, Al Viro wrote:
> Yes, and...?  CIFS also doesn't have hardlinks, so _there_ d_find_alias()
> is just fine.

It does have hardlinks, look at cifs_hardlink and functions called from
it.
