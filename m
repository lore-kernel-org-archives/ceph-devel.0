From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: g_conf.id, g_conf.name, g_conf.type and friends
Date: Wed, 23 Feb 2011 13:58:19 -0800
Message-ID: <AANLkTi=zwxN0RW-gjejEONnvpR+RyVUTdx4mWB1qh=En@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38972 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab1BWV75 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 16:59:57 -0500
Received: by fxm17 with SMTP id 17so4556794fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 13:59:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

So I'm trying to reorganize the common_init code a little bit, in
preparation for tackling issue #815.
I noticed there is a little bit of confusion about g_conf.id,
g_conf.name, g_conf.type, and g_conf.entity_name.
Here is my take on it.

*** g_conf.id: this is a username or a daemon name, depending on the program.
It defaults to "admin" for our various command-line tools, but can be
changed by the -i command-line argument.
For an MDS, this would be "a" or "b", or similar.

*** g_conf.type: nobody seems to know what this is.
It seems like at one point, g_conf.type was intended to be one of
"auth", "mon", "osd", "mds", or "client".

However, over time, the code has drifted away from this, and
g_conf.type usually ends up being the program name.
There are also some code paths that could lead to it being an empty string.

A quick search for "g_conf.type" in the code reveals only two uses:
1. variable expansion of $type in ceph_config
2. used to calculate logfile symlink names

*** g_conf.name: created out of g_conf.type and g_conf.id

*** g_conf.entity_name: seems to be sort of a parsed version of the
preceding variables. g_conf.entity_name actually gets used and seems
to be correct.

Questions:
* Do we even need g_conf.name any more? We could just call
g_conf.entity_name.to_str() and get the same thing. (Actually, a
better thing.)
* Should we rename g_conf.type to g_conf.program_name? Program name is
a clear and unambiguous concept; what we have now is not useful.
* Should $type expand out to ceph_entity_type_name(g_conf.entity_name.type)?
In practice, this would bring us back to $type being "auth", "mon",
"osd", "mds", or "client", etc. again. This seems to be the original
intention of the system.
* Allowing users to set id is great. Allowing them to set the program
type seems wrong. Yet there is some evil code lurking in there that
parses the id parameter and tries to use it to set g_conf.type.

Colin
