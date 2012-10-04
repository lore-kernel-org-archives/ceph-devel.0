From: Gregory Farnum <greg@inktank.com>
Subject: mds heartbeat information
Date: Wed, 3 Oct 2012 18:23:48 -0700
Message-ID: <CAPYLRziWTgvNusSNqCw5RfhBZt=DEny2YBvogE==6MqTFSj3-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41311 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab2JDBXt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 21:23:49 -0400
Received: by ieak13 with SMTP id k13so18730206iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 18:23:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I was asked to send this to the list. At some point it will be
properly documented, but for the moment...

The mds heartbeat controls are mds_beacon_interval and
mds_beacon_grace. (So named because the beacon is used for a little
bit more than heartbeating; but it also serves heartbeat purposes and
its other duties aren't harmed by changing these settings.) A
heartbeat is sent every mds_beacon_interval_seconds, and the monitor
will mark an MDS laggy if the monitor doesn't receive a beacon for
mds_beacon_grace seconds.

If you change mds_beacon_grace you should also change
mds_session_timeout and mds_reconnect_timeout to match, so that
mds_reconnect_timeout = (mds_session_timeout - mds_beacon_grace).
These tunables specify how long a recovering MDS waits before it
declares clients as having failed, which is why it needs to be
adjusted as well.
-Greg
