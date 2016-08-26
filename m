From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH] ceph: fix symbol versioning for ceph_monc_do_statfs
Date: Fri, 26 Aug 2016 14:40:34 +0200
Message-ID: <7bd07499-ac33-9659-0a8a-a3ddfa96f13d@suse.cz>
References: <1465823125-171114-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465823125-171114-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sage Weil <sage@redhat.com>, Jan Beulich <jbeulich@suse.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Alex Elder <elder@linaro.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 2016-06-13 15:04, Arnd Bergmann wrote:
> The genksyms helper in the kernel cannot parse a type definition
> like "typeof(((type *)0)->keyfld)" that is used in the DEFINE_RB_FUNCS
> helper, causing the following EXPORT_SYMBOL() statement to be ignored
> when computing the crcs, and triggering a warning about this:
> 
> WARNING: "ceph_monc_do_statfs" [fs/ceph/ceph.ko] has no CRC

FYI, Nick fixed the genksyms state machine to cope with this syntax. See
commits

5c6f3225d00d kbuild: Regenerate genksyms lexer
4fab91605a6b kbuild: genksyms fix for typeof handling

in today's linux-next. So the workaround can eventually be reverted.

Michal
