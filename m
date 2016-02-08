From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Dev Meeting followup on compression
Date: Mon, 8 Feb 2016 19:34:07 +0300
Message-ID: <56B8C37F.9050904@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:32952 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbcBHQeJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 11:34:09 -0500
Received: by mail-lb0-f177.google.com with SMTP id x4so87197159lbm.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 08:34:08 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id l8sm4180237lfe.24.2016.02.08.08.34.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Feb 2016 08:34:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Guys,

let me summarize what we decided regarding compression support in Ceph 
during the Dev Meeting last week.

Below are possible implementation options, their pros/cons and the 
conclusion.

1) Add compression support to RGW.
Pros/Cons:
+ Simple
+ Reduced inter-component traffic
- Limited to specific clients
- Will conflict with partial read/writes if any appear

Alyona Kiseleva from Mirantis (akyseleva@mirantis.com) will start 
implementing this promptly. You can ask additional questions to her via 
e-mail or during daily RGW stendups she is planning to attend regularly.

2) Add basic compression support to BlueStore. Basic = "Append only" 
functionality to be implemented. Specific "append only" hint/flag needs 
to be introduced for object creation interface.

Pros/Cons:
+ Moderate complexity
+ Suits for any client/PG backend
+ Good isolation from other Ceph components
- Limited applicability
- additional 50-200% CPU load for the cluster since we compress each 
replica/EC shard independently
- no inter-component traffic saving
- recovery procedure requires decompress/recompress sequence

Mirantis ( me specifically ) will start blueprint/POC creation for this 
promptly. I'm planning to attend daily RBD syncup regularly to inform on 
the progress.

3) Add full compression support at BlueStore. This includes 2) + support 
for random object writes.
Pros/Cons:
+ Severe complexity
+ Suits for any client/PG backend
+ Good isolation from other Ceph components
- additional 50-200% CPU load for the cluster since we compress each 
replica/EC shard independently
- no inter-component traffic saving
- recovery procedure requires decompress/recompress sequence

On-Hold for now. Will require insert/delete data range for the store.

4) Add basic ( append only ) compression support at OSD using interim 
PGBackend.

Pros/Cons:
+ Moderate complexity
+ Suits for any client/PG backend
+ Data compressed before replication/"EC inflation"
+ inter-component traffic saving
+ recovery procedure don't need decompress/recompress sequence
- Too tight(danger) integration into Ceph internals
- Limited applicability
- Bad experience with "append only" notion for EC and desire to avoid 
that for compression

Rejected ( Personally I'd prefer this option with subsequent mutation to 
full RW support. The rationale is the reduced CPU load comparing to 
options 2 & 3)

Any additional comments/suggestions are welcome.

Thanks,
Igor
