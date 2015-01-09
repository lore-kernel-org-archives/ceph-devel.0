From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: RFC: new rados whereis command
Date: Fri, 9 Jan 2015 15:21:59 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE84A455@CERNXCHG44.cern.ch>
References: <5499EB3C.2040602@dachary.org>,<alpine.DEB.2.00.1412291203020.5967@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:51979 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbbAIP1d convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 10:27:33 -0500
In-Reply-To: <alpine.DEB.2.00.1412291203020.5967@cobra.newdream.net>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi all, 

happy new year and thanks for your feedback, some things got much more clear to me after these comments.

I have reworked the implementation but before I make a new pull request I would like to clarify some points.

I have the following problems:

- to do a table printout I need to use the Formatter class, which is not available when linking only to librados. 
- I have added RadosWhereis to librados_internal and link the 'rados' command also against the internal library to be able to use Formatter in RadosWhereis. This is not nice, but I didn't find another solution. Any suggestion here?

Sage comments point into the direction to shrink the whereis_t structure and not to have a vector<whereis_t> . I did this.

I propose now this as minimal structure (if you don't like the weight, I can remove it, probably it does not need to be there):
=============================================================================================

typedef struct whereis {
    std::string oname; // object name                                                                                                                                                                         
    int32_t pg_seed;
    int64_t pool_id;

    typedef struct osd {
      osd(int64_t osdid) : id(osdid) {}
      int64_t id;
      int32_t weight;
    } osd_t;

    std::vector<osd_t> acting_osds; // vector of 'acting' OSDs for a given object                                                                                                                             
  } whereis_t;

=============================================================================================

I removed the IP and the host_names from the structure, but optionally return these in the whereis() call as strings. For (my) use case I don't need sockaddr_t but I need to build a URL either with an IP or better a human readable host-name. I hope you can live with that interface. I think it is the most useful as external API where sockaddr does not help. If you prefer I can make an extra call to get the ip,hostname vectors. In this way I consult the OSDmap only once.

//  'whereis' of objects                                                                                                                                                                                  
    static int whereis(IoCtx &ioctx,
                       const std::string &oname,
                       whereis_t &locations,
		       std::vector<std::string> *ip_vector, // return vector of IP matching OSD vector in acting_osds.id - set 0 if not wanted                                                                
                       std::vector<std::vector<std::string> > *hostname_vector); // return reverse DNS hostname vector matching ip_vector before - set 0 if not wanted            


I have extended the 'rados whereis' command a bit.

Most basic output in table, table-kv, xml, json is:

+---------+------------------+-------------+
| osd:id  | osd:ip           | osd:weight  |
+---------+------------------+-------------+
| 4       | 128.142.187.226  | 65536       |
| 1       | 128.142.187.226  | 65536       |
+---------+------------------+-------------+

-------------------------------------------------------------
key::osd:id="4" key::osd:ip="128.142.187.226" key::osd:weight="65536" 
key::osd:id="1" key::osd:ip="128.142.187.226" key::osd:weight="65536" 

-------------------------------------------------------------
<osd>
 <id>4</id>
 <ip>128.142.187.226</ip>
 <weight>65536</weight>
</osd>
<osd>
 <id>1</id>
 <ip>128.142.187.226</ip>
 <weight>65536</weight>
</osd>

-------------------------------------------------------------
{ "id": 4,
  "ip": "128.142.187.226",
  "weight": 65536}{ "id": 1,
  "ip": "128.142.187.226",
  "weight": 65536}
-------------------------------------------------------------


I added two options '--dns' to translate ips and '-l' to get more information on the given object => rados whereis --dns -l <obj-name>:

+---------------------------------------+-------------+-----------+-------------+----------------+-----------------+-----------------+-------------------+----------+----------+
| obj:name                              | obj:exists  | obj:size  | obj:mtime   | obj:omap.size  | obj:xattr.size  | obj:locks.size  | obj:watcher.size  | pg:name  | pg:seed  |
+---------------------------------------+-------------+-----------+-------------+----------------+-----------------+-----------------+-------------------+----------+----------+
| 8b3ba952-e4ed-4577-83d0-1fadd724ed4d  | 1           | 2056      | 1420720812  | 3              | 3               | 1               | 0                 | 2.9      | 9        |
+---------------------------------------+-------------+-----------+-------------+----------------+-----------------+-----------------+-------------------+----------+----------+
+---------------------------------------+-------------+-------------+-------------+----------------+-----------------+-----------------+-------------------+
| pool:name                             | pool:id     | pool:type   | pool:size   | pool:minsize   | pool:flags      | pool:rule       | pool:objecthash   |
+---------------------------------------+-------------+-------------+-------------+----------------+-----------------+-----------------+-------------------+
| 2rep                                  | 2           | replicated  | 2           | 1              | hashpspool      | 0               | rjenkins          |
+---------------------------------------+-------------+-------------+-------------+----------------+-----------------+-----------------+-------------------+
+---------------------------------------+------------------+-------------+--------------------+
| osd:id                                | osd:ip           | osd:weight  | osd:host:name[0]   |
+---------------------------------------+------------------+-------------+--------------------+
| 4                                     | 128.142.187.226  | 65536       | lxbst2227.cern.ch  |
| 1                                     | 128.142.187.226  | 65536       | lxbst2227.cern.ch  |
+---------------------------------------+------------------+-------------+--------------------+

-------------------------------------------------------------
key::obj:name="8b3ba952-e4ed-4577-83d0-1fadd724ed4d" key::obj:exists="1" key::obj:size="2056" key::obj:mtime="1420720812" key::obj:omap.size="3" key::obj:xattr.size="3" key::obj:locks.size="1" key::obj:watcher.size="0" key::pg:name="2.9" key::pg:seed="9" 
key::pool:name="2rep" key::pool:id="2" key::pool:type="replicated" key::pool:size="2" key::pool:minsize="1" key::pool:flags="hashpspool" key::pool:rule="0" key::pool:objecthash="rjenkins" 
key::osd:id="4" key::osd:ip="128.142.187.226" key::osd:weight="65536" key::osd:host:name[0]="lxbst2227.cern.ch" 
key::osd:id="1" key::osd:ip="128.142.187.226" key::osd:weight="65536" key::osd:host:name[0]="lxbst2227.cern.ch" 

-------------------------------------------------------------
<obj>
 <name>8b3ba952-e4ed-4577-83d0-1fadd724ed4d</name>
 <exists>1</exists>
 <size>2056</size>
 <mtime>1420720812</mtime>
 <omap.size>3</omap.size>
 <xattr.size>3</xattr.size>
 <locks.size>1</locks.size>
 <watcher.size>0</watcher.size>
</obj>
<pg>
 <name>2.9</name>
 <seed>9</seed>
</pg>
<pool>
 <name>2rep</name>
 <id>2</id>
 <type>replicated</type>
 <size>2</size>
 <minsize>1</minsize>
 <flags>hashpspool</flags>
 <rule>0</rule>
 <objecthash>rjenkins</objecthash>
</pool>
<osd>
 <id>4</id>
 <ip>128.142.187.226</ip>
 <weight>65536</weight>
 <host>
  <name>lxbst2227.cern.ch</name>
 </host>
</osd>
<osd>
 <id>1</id>
 <ip>128.142.187.226</ip>
 <weight>65536</weight>
 <host>
  <name>lxbst2227.cern.ch</name>
 </host>
</osd>

-------------------------------------------------------------
{ "name": "8b3ba952-e4ed-4577-83d0-1fadd724ed4d",
  "exists": 1,
  "size": 2056,
  "mtime": 1420720812,
  "omap.size": 3,
  "xattr.size": 3,
  "locks.size": 1,
  "watcher.size": 0}{ "name": "2.9",
  "seed": 9}{ "name": "2rep",
  "id": 2,
  "type": "replicated",
  "size": 2,
  "minsize": 1,
  "flags": "hashpspool",
  "rule": 0,
  "objecthash": "rjenkins"}{ "id": 4,
  "ip": "128.142.187.226",
  "weight": 65536,
  "host": [
        "lxbst2227.cern.ch"]}{ "id": 1,
  "ip": "128.142.187.226",
  "weight": 65536,
  "host": [
        "lxbst2227.cern.ch"]}
-------------------------------------------------------------


It would be great to be able to add the state of the PG, but I couldn't find any API to get to pg_stat_t ... is there one?

Please provide feedback, then I will update the pull request.

Thanks, 
Andreas.
