From: Ilya Dryomov <idryomov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v14.2.5 Nautilus released
Date: Tue, 10 Dec 2019 14:52:26 +0100
Message-ID: <CAOi1vP8JyKzsc9mxHjMZWs_SaXQD7GrNbxRic9NvChxi_dUbow@mail.gmail.com>
References: <87sglscy4z.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-a8pt6IJUokc@public.gmane.org>
In-Reply-To: <87sglscy4z.fsf-IBi9RG/b67k@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-users-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-users-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-users-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-users-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-users-leave-a8pt6IJUokc@public.gmane.org>
To: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Cc: ceph-announce-a8pt6IJUokc@public.gmane.org, ceph-users <ceph-users-a8pt6IJUokc@public.gmane.org>, dev-a8pt6IJUokc@public.gmane.org, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Dec 10, 2019 at 10:45 AM Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org> wrote:
>
> This is the fifth release of the Ceph Nautilus release series. Among the many
> notable changes, this release fixes a critical BlueStore bug that was introduced
> in 14.2.3. All Nautilus users are advised to upgrade to this release.
>
> For the complete changelog entry, please visit the release blog at
> https://ceph.io/releases/v14-2-5-nautilus-released/
>
> Notable Changes
> ---------------
>
> Critical fix:
>
> * This release fixes a `critical BlueStore bug <https://tracker.ceph.com/issues/42223>`_
>   introduced in 14.2.3 (and also present in 14.2.4) that can lead to data
>   corruption when a separate "WAL" device is used.
>
> New health warnings:
>
> * Ceph will now issue health warnings if daemons have recently crashed. Ceph
>   has been collecting crash reports since the initial Nautilus release, but the
>   health alerts are new. To view new crashes (or all crashes, if you've just
>   upgraded)::
>
>     ceph crash ls-new
>
>   To acknowledge a particular crash (or all crashes) and silence the health warning::
>
>     ceph crash archive <crash-id>
>     ceph crash archive-all
>
> * Ceph will now issue a health warning if a RADOS pool has a ``pg_num``
>   value that is not a power of two. This can be fixed by adjusting
>   the pool to a nearby power of two::
>
>     ceph osd pool set <pool-name> pg_num <new-pg-num>
>
>   Alternatively, the warning can be silenced with::
>
>     ceph config set global mon_warn_on_pool_pg_num_not_power_of_two false
>
> * Ceph will issue a health warning if a RADOS pool's ``size`` is set to 1
>   or, in other words, if the pool is configured with no redundancy. Ceph will
>   stop issuing the warning if the pool size is set to the minimum
>   recommended value::
>
>     ceph osd pool set <pool-name> size <num-replicas>
>
>   The warning can be silenced with::
>
>     ceph config set global mon_warn_on_pool_no_redundancy false
>
> * A health warning is now generated if the average osd heartbeat ping
>   time exceeds a configurable threshold for any of the intervals
>   computed. The OSD computes 1 minute, 5 minute and 15 minute
>   intervals with average, minimum and maximum values.  New configuration
>   option `mon_warn_on_slow_ping_ratio` specifies a percentage of
>   `osd_heartbeat_grace` to determine the threshold.  A value of zero
>   disables the warning. New configuration option `mon_warn_on_slow_ping_time`
>   specified in milliseconds over-rides the computed value, causes a warning
>   when OSD heartbeat pings take longer than the specified amount.
>   A new admin command, `ceph daemon mgr.# dump_osd_network [threshold]`, will
>   list all connections with a ping time longer than the specified threshold or
>   value determined by the config options, for the average for any of the 3 intervals.
>   Another new admin command, `ceph daemon osd.# dump_osd_network [threshold]`,
>   will do the same but only including heartbeats initiated by the specified OSD.
>
> Changes in the telemetry module:
>
> * The telemetry module now has a 'device' channel, enabled by default, that
>   will report anonymized hard disk and SSD health metrics to telemetry.ceph.com
>   in order to build and improve device failure prediction algorithms. Because
>   the content of telemetry reports has changed, you will need to re-opt-in
>   with::
>
>     ceph telemetry on
>
>   You can view exactly what information will be reported first with::
>
>     ceph telemetry show
>     ceph telemetry show device   # specifically show the device channel
>
>   If you are not comfortable sharing device metrics, you can disable that
>   channel first before re-opting-in:
>
>     ceph config set mgr mgr/telemetry/channel_crash false

This should be channel_device, right?

Thanks,

                Ilya
_______________________________________________
ceph-users mailing list -- ceph-users-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-users-leave-a8pt6IJUokc@public.gmane.org
