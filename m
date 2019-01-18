From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 6/9] ceph: quota: Cleanup license mess
Date: Fri, 18 Jan 2019 11:54:00 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1901181153310.1647@nanos.tec.linutronix.de>
References: <20190117231416.111952141@linutronix.de> <20190117231501.346447710@linutronix.de> <CAOi1vP_zHqKvoqZ3Bupip3=Hcoy6fY4jEF-kf46-A0g4ZTNpcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_zHqKvoqZ3Bupip3=Hcoy6fY4jEF-kf46-A0g4ZTNpcw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Luis Henriques <lhenriques@suse.com>, Jiri Kosina <jkosina@suse.cz>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, 18 Jan 2019, Ilya Dryomov wrote:

> On Fri, Jan 18, 2019 at 12:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Precise and non-ambiguous license information is important. The recently
> > added aegis header file has a SPDX license identifier, which is nice, but
> 
> Looks like cut-and-paste from crypto/aegis.h patch?

Oops, sorry.

> I'm changing this to say "recently added quota.c file".

Thank you!

      tglx
