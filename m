From: Sage Weil <sage@newdream.net>
Subject: Re: mon config update
Date: Thu, 11 Jan 2018 15:10:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801111509180.20939@piezo.novalocal>
References: <alpine.DEB.2.11.1801051716570.24931@piezo.novalocal> <2b36d420-2646-4955-24ae-ed4a3688c094@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1358594043-1515683469=:20939"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:45142 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeAKPLK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jan 2018 10:11:10 -0500
In-Reply-To: <2b36d420-2646-4955-24ae-ed4a3688c094@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1358594043-1515683469=:20939
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 8 Jan 2018, Piotr Dałek wrote:
> Wouldn't mind having a "changeable in runtime" column in these outputs. I know
> it's semi-reliable, but it's still better than experimenting or searching for
> it in code (which may be difficult for non-devs).

Several parts of this.

1. 'config help'

$ bin/ceph config help debug_osd
debug_osd - Debug level for osd
  (std::string, advanced)
  Default: 1/5
  Can update at runtime: true

(also in the JSON dump).

2. 'config dump' and 'config get' have a new "RW" column (suggestions for 
a better short column name are welcome!):

$ bin/ceph config get osd.0
WHO    MASK LEVEL     OPTION                    VALUE  RW
osd         advanced  debug_bdev                20/20  Y
osd         advanced  debug_bluefs              20/20  Y
osd         advanced  debug_bluestore           30/30  Y
osd         advanced  debug_filestore           20/20  Y
osd         advanced  debug_journal             20/20  Y
osd         advanced  debug_ms                  1/1    Y
global      advanced  mon_pg_warn_min_per_osd   3      Y
osd         advanced  osd_copyfrom_max_chunk    524288 Y
global      advanced  osd_crush_chooseleaf_type 0      Y
osd         developer osd_debug_misdirected_ops true   Y
osd         developer osd_debug_op_order        true   Y
osd.0       advanced  osd_objectstore           foo

3. We obviously need to improve the is_safe() implementation to make this 
more accurate.  My current plan is add annotations for if the option can 
update at runtime, only takes effect at startup, at daemon creation time, 
or cluster creation time.  In most cases the guess is right, so hopefully 
not too many annotations will be needed.

4. The 'config show' now indicates if a setting the mon tried to set
failed to take effect:

$ bin/ceph config show osd.0
NAME                      VALUE     SOURCE  OVERRIDES IGNORES
...
osd_journal_size          100       file
osd_objectstore           bluestore file              mon
osd_pool_default_min_size 1         mon
osd_pool_default_size     1         mon
...

The IGNORES column is meant to make sense next to SOURCE and OVERRIDES.
For example, mon_data source is mon, overrides nothing, but ignores 'mon'.
In reality, the only value IGNORES will currently ever have is 'mon',
since trying to do e.g. 'ceph daemon ... config set ...' will error out
without setting anything so you never get into a conflicting state. In
principle we could eventually show soenthing else here if there is a
setting that is forced based on on-disk state (e.g., osd_objectstore) that
might conflict with a setting that only works at daemon creation time.
In reality we just ignore setting in that case; I'm not sure if it would
make sense to show it here (or would it?).

sage

--8323329-1358594043-1515683469=:20939--
