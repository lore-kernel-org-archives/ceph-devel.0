From: Kay Sievers <kay@vrfy.org>
Subject: Re: [PATCH] rules: add by-parttypeuuid rule for GPT
 labeled partitions
Date: Fri, 9 May 2014 23:51:21 +0200
Message-ID: <CAPXgP11h0C0BA0u+CfTV2LDz2T0vdRBThpxXu-0U-3RX2gnzDw@mail.gmail.com>
References: <1399671097-32015-1-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <systemd-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1399671097-32015-1-git-send-email-sage@inktank.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/systemd-devel>,
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/systemd-devel>
List-Post: <mailto:systemd-devel@lists.freedesktop.org>
List-Help: <mailto:systemd-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/systemd-devel>,
 <mailto:systemd-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: systemd-devel-bounces@lists.freedesktop.org
Sender: "systemd-devel" <systemd-devel-bounces@lists.freedesktop.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, systemd-devel@lists.freedesktop.org
List-Id: ceph-devel.vger.kernel.org

On Fri, May 9, 2014 at 11:31 PM, Sage Weil <sage@inktank.com> wrote:
> The Ceph OSD initialization relies on identifying GPT partitions by type
> in order to mount data volumes and start daemons.  Currently we ship this
> rule separately, but it is awkward to duplicate the conditional logic that
> precedes this block and it would be much simpler if it were simply included
> in the upstream rules.

Types are by definition not unique. The symlinks in /dev/disk/by-*/
are *expected* to be unique.

We handle duplicated labels, but they are specified by humans,
multiple partitions with the same GPT types are just normal expected
behavior; and they would have no order or priority, they just
overwrite each other depending on probing order.

We should not add such things, the logic to find these volumes at
bootup are better handled by a specific program like systemd's
systemd-gpt-auto-generator, without putting unreliable and
unpredictable content into /dev.

  http://www.freedesktop.org/software/systemd/man/systemd-gpt-auto-generator.html
  http://www.freedesktop.org/wiki/Specifications/DiscoverablePartitionsSpec/

Thanks,
Kay
