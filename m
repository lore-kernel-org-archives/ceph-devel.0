From: Sage Weil <sweil@redhat.com>
Subject: 'pg stat' structured output
Date: Sun, 21 Dec 2014 07:18:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412210716230.10128@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbaLUPS2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 21 Dec 2014 10:18:28 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-calamari@ceph.com
Cc: ceph-devel@vger.kernel.org

I recently switched this around to not to a full 'pg dump' for the 
formatted 'pg stat' command.  The problem is that the current code that 
does the num_pg_by_state uses the state name as the key.  This 
includes 'active+clean' and other instances of +, which is not a valid 
character for an XML token.

Is calamari relying on this code anywhere or can we switch this 
around to be

<state>
 <name>active+clean</name>
 <num>123</num>
</state>

(or equivalent JSON)?

sage


GET pg/stat: json 200
GET pg/stat: xml 200
FAILURE: url  http://localhost:5000/api/v0.1/pg/stat
Invalid XML returned: "not well-formed (invalid token): line 4, column 40"
Response content:  
<response>
  <output>
    <pg_summary><num_pg_by_state><active+clean>24</active+clean></num_pg_by_state><version>55</version><num_pgs>24</num_pgs><num_bytes>3892</num_bytes><raw_bytes_used>491817414656</raw_bytes_used><raw_bytes_avail>663907856384</raw_bytes_avail><raw_bytes>1217698979840</raw_bytes></pg_summary>

  </output>
  <status>
    OK
  </status>
</response>
