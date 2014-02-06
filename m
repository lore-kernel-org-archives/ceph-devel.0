From: Jeremy Allison <jra@samba.org>
Subject: Re: [PATCH v2] ceph: fix posix ACL hooks
Date: Thu, 6 Feb 2014 12:51:23 -0800
Message-ID: <20140206205123.GH6588@samba2>
References: <CA+55aFwTuBDHgQoTymr8OtE-+k=+pX0T_eb+fff0K+Pa3C-g-Q@mail.gmail.com>
 <20140130075421.GA10050@infradead.org>
 <CA+55aFxbVFpy8Y8P5fMCmmTSGbFxU9dTbOj9uTH+fKWGUzwgNg@mail.gmail.com>
 <20140203102943.GF11829@infradead.org>
 <CA+55aFytvTPdBsv6BwSomUGWXZ_tKP=BxaeJ7FXBft0JNnjBCQ@mail.gmail.com>
 <20140203211955.GY10323@ZenIV.linux.org.uk>
 <CA+55aFyfPVgGXn_hSBnnVyzWn4AbZQ40MPk_AoKB_6uC6LJqPg@mail.gmail.com>
 <20140203213926.GA10323@ZenIV.linux.org.uk>
 <CA+55aFyKN47V56oksujoojdV_uhoFYJxURg3RNHXbLFSqqDnGA@mail.gmail.com>
 <20140203223127.GE10323@ZenIV.linux.org.uk>
Reply-To: Jeremy Allison <jra@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140203223127.GE10323@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Ilya Dryomov <ilya.dryomov@inktank.com>, Sage Weil <sage@inktank.com>, Dave Jones <davej@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Guangliang Zhao <lucienchao@gmail.com>, Li Wang <li.wang@ubuntykylin.com>, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

On Mon, Feb 03, 2014 at 10:31:27PM +0000, Al Viro wrote:
> 
> > And the fact is, filesystems with hardlinks and path-name-based
> > operations do exist. cifs with the unix extensions is one of them.
> 
> Pox on Tridge...

Actually you have to blame me for that. Tridge always
*HATED* the UNIX extensions :-).
