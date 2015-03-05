From: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pool distribution quality report script
Date: Thu, 05 Mar 2015 16:58:41 -0600
Message-ID: <54F8DFA1.6000107@redhat.com>
References: <54F7D78D.2090200@redhat.com>	<CA+z5DszPviPvJd3WS2_3RKd_GXGf8NkCe8og2EQ8wZZsbe=kUA@mail.gmail.com>	<54F8A468.30707@redhat.com>
	<CANvNco10mVkMytCwGqKtxRpR-64OFAn4weoopqD3cNGUar3-fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANvNco10mVkMytCwGqKtxRpR-64OFAn4weoopqD3cNGUar3-fQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Burley <david-kIZutuWb7l0/lw2aP8KBIQC/G2K4zDHf@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi David,

Mind sending me the output of "ceph pg dump -f json"?

thanks!
Mark

On 03/05/2015 12:52 PM, David Burley wrote:
> Mark,
>
> It worked for me earlier this morning but the new rev is throwing a
> traceback:
>
> $ ceph pg dump -f json | python ./readpgdump.py > pgdump_analysis.txt
> dumped all in format json
> Traceback (most recent call last):
>    File "./readpgdump.py", line 294, in <module>
>      parse_json(data)
>    File "./readpgdump.py", line 263, in parse_json
>      print_report(pool_counts, total_counts, "JSON")
>    File "./readpgdump.py", line 119, in print_report
>      print_data(data, pool_weights, total_weights)
>    File "./readpgdump.py", line 161, in print_data
>      print format_line("Efficiency score using optimal weights for pool
> %s: %.1f%%" % (pool, efficiency_score(data[name],
> weights['acting_totals'])))
>    File "./readpgdump.py", line 71, in efficiency_score
>      if weights and weights[osd]:
> KeyError: 0
>
> On Thu, Mar 5, 2015 at 1:46 PM, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> <mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>> wrote:
>
>     Hi Blair,
>
>     I've updated the script and it now (theoretically) computes optimal
>     crush weights based on both primary and secondary acting set OSDs.
>     It also attempts to show you the efficiency of equal weights vs
>     using weights optimized for different pools (or all pools).  This is
>     done by looking at the way weights would be assigned and how they
>     would affect the current pool distribution, then looking at the skew
>     for the heaviest weighted OSD vs the average.
>
>     Unfortunately the output has now become beastly and complex (granted
>     this is a large cluster with many pools!).  I think the trick now is
>     how to make the interface for this more manageable.  For instance
>     perhaps it's not interesting to know how one pool's weights affect
>     the efficiency of the acting primary OSDs for another pool.
>
>     I've included sample output, but it's huge (15K lines long!)
>
>     Mark
>
>
>     On 03/05/2015 01:52 AM, Blair Bethwaite wrote:
>
>         Hi Mark,
>
>         Cool, that looks handy. Though it'd be even better if it could go a
>         step further and recommend re-weighting values to balance things out
>         (or increased PG counts where needed).
>
>         Cheers,
>
>         On 5 March 2015 at 15:11, Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
>         <mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>> wrote:
>
>             Hi All,
>
>             Recently some folks showed interest in gathering pool
>             distribution
>             statistics and I remembered I wrote a script to do that a
>             while back. It was
>             broken due to a change in the ceph pg dump output format
>             that was committed
>             a while back, so I cleaned the script up, added detection of
>             header fields,
>             automatic json support, and also added in calculation of
>             expected max and
>             min PGs per OSD and std deviation.
>
>             The script is available here:
>
>             https://github.com/ceph/ceph-__tools/blob/master/cbt/tools/__readpgdump.py
>             <https://github.com/ceph/ceph-tools/blob/master/cbt/tools/readpgdump.py>
>
>             Some general comments:
>
>             1) Expected numbers are derived by treating PGs and OSDs as a
>             balls-in-buckets problem ala Raab & Steger:
>
>             http://www14.in.tum.de/__personen/raab/publ/balls.pdf
>             <http://www14.in.tum.de/personen/raab/publ/balls.pdf>
>
>             2) You can invoke it either by passing it a file or stdout, ie:
>
>             ceph pg dump -f json | ./readpgdump.py
>
>             or
>
>             ./readpgdump.py ~/pgdump.out
>
>
>             3) Here's a snippet of some of some sample output from a 210
>             OSD cluster.
>             Does this output make sense to people?  Is it useful?
>
>                 [nhm@burnupiX tools]$ ./readpgdump.py ~/pgdump.out
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | Detected input as plain
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | Pool ID: 681
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | Participating OSDs: 210
>                 |
>                 | Participating PGs: 4096
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in Primary Role (Acting)
>                 |
>                 | Expected PGs Per OSD: Min: 4, Max: 33, Mean: 19.5, Std
>                 Dev: 7.2
>                 |
>                 | Actual PGs Per OSD: Min: 7, Max: 43, Mean: 19.5, Std
>                 Dev: 6.5
>                 |
>                 | 5 Most Subscribed OSDs: 199(43), 175(36), 149(34),
>                 167(32), 20(31)
>                 |
>                 | 5 Least Subscribed OSDs: 121(7), 46(7), 70(8), 94(9),
>                 122(9)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 54.6%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in Secondary Role (Acting)
>                 |
>                 | Expected PGs Per OSD: Min: 18, Max: 59, Mean: 39.0,
>                 Std Dev: 10.2
>                 |
>                 | Actual PGs Per OSD: Min: 17, Max: 61, Mean: 39.0, Std
>                 Dev: 9.7
>                 |
>                 | 5 Most Subscribed OSDs: 44(61), 14(60), 2(59),
>                 167(59), 164(57)
>                 |
>                 | 5 Least Subscribed OSDs: 35(17), 31(20), 37(20),
>                 145(20), 16(20)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 36.0%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in All Roles (Acting)
>                 |
>                 | Expected PGs Per OSD: Min: 32, Max: 83, Mean: 58.5,
>                 Std Dev: 12.5
>                 |
>                 | Actual PGs Per OSD: Min: 29, Max: 93, Mean: 58.5, Std
>                 Dev: 14.6
>                 |
>                 | 5 Most Subscribed OSDs: 199(93), 175(92), 44(92),
>                 167(91), 14(91)
>                 |
>                 | 5 Least Subscribed OSDs: 121(29), 35(30), 47(30),
>                 131(32), 145(32)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 37.1%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in Primary Role (Up)
>                 |
>                 | Expected PGs Per OSD: Min: 4, Max: 33, Mean: 19.5, Std
>                 Dev: 7.2
>                 |
>                 | Actual PGs Per OSD: Min: 7, Max: 43, Mean: 19.5, Std
>                 Dev: 6.5
>                 |
>                 | 5 Most Subscribed OSDs: 199(43), 175(36), 149(34),
>                 167(32), 20(31)
>                 |
>                 | 5 Least Subscribed OSDs: 121(7), 46(7), 70(8), 94(9),
>                 122(9)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 54.6%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in Secondary Role (Up)
>                 |
>                 | Expected PGs Per OSD: Min: 18, Max: 59, Mean: 39.0,
>                 Std Dev: 10.2
>                 |
>                 | Actual PGs Per OSD: Min: 17, Max: 61, Mean: 39.0, Std
>                 Dev: 9.7
>                 |
>                 | 5 Most Subscribed OSDs: 44(61), 14(60), 2(59),
>                 167(59), 164(57)
>                 |
>                 | 5 Least Subscribed OSDs: 35(17), 31(20), 37(20),
>                 145(20), 16(20)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 36.0%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in All Roles (Up)
>                 |
>                 | Expected PGs Per OSD: Min: 32, Max: 83, Mean: 58.5,
>                 Std Dev: 12.5
>                 |
>                 | Actual PGs Per OSD: Min: 29, Max: 93, Mean: 58.5, Std
>                 Dev: 14.6
>                 |
>                 | 5 Most Subscribed OSDs: 199(93), 175(92), 44(92),
>                 167(91), 14(91)
>                 |
>                 | 5 Least Subscribed OSDs: 121(29), 35(30), 47(30),
>                 131(32), 145(32)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 37.1%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>
>
>
>             This is shown for all the pools, followed by the totals:
>
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | Pool ID: Totals (All Pools)
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | Participating OSDs: 210
>                 |
>                 | Participating PGs: 131072
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in Primary Role (Acting)
>                 |
>                 | Expected PGs Per OSD: Min: 542, Max: 705, Mean: 624.0,
>                 Std Dev: 40.8
>                 |
>                 | Actual PGs Per OSD: Min: 356, Max: 917, Mean: 624.0,
>                 Std Dev: 176.2
>                 |
>                 | 5 Most Subscribed OSDs: 167(917), 123(876), 23(873),
>                 194(869), 60(868)
>                 |
>                 | 5 Least Subscribed OSDs: 117(356), 155(358), 46(361),
>                 78(361), 70(362)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 32.0%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in Secondary Role (Acting)
>                 |
>                 | Expected PGs Per OSD: Min: 1132, Max: 1363, Mean:
>                 1248.0, Std Dev: 57.8
>                 |
>                 | Actual PGs Per OSD: Min: 864, Max: 1554, Mean: 1248.0,
>                 Std Dev: 229.9
>                 |
>                 | 5 Most Subscribed OSDs: 182(1554), 142(1552), 4(1548),
>                 123(1544),
>                 100(1540)|
>                 | 5 Least Subscribed OSDs: 16(864), 55(885), 18(885),
>                 42(885), 85(891)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 19.7%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in All Roles (Acting)
>                 |
>                 | Expected PGs Per OSD: Min: 1730, Max: 2013, Mean:
>                 1872.0, Std Dev: 70.7
>                 |
>                 | Actual PGs Per OSD: Min: 1252, Max: 2420, Mean:
>                 1872.0, Std Dev: 402.0
>                 |
>                 | 5 Most Subscribed OSDs: 123(2420), 142(2403),
>                 195(2390), 100(2389),
>                 182(2380)|
>                 | 5 Least Subscribed OSDs: 55(1252), 42(1268), 16(1271),
>                 85(1271),
>                 155(1275) |
>                 | Avg Deviation from Most Subscribed OSD: 22.6%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in Primary Role (Up)
>                 |
>                 | Expected PGs Per OSD: Min: 542, Max: 705, Mean: 624.0,
>                 Std Dev: 40.8
>                 |
>                 | Actual PGs Per OSD: Min: 356, Max: 917, Mean: 624.0,
>                 Std Dev: 176.2
>                 |
>                 | 5 Most Subscribed OSDs: 167(917), 123(876), 23(873),
>                 194(869), 60(868)
>                 |
>                 | 5 Least Subscribed OSDs: 117(356), 155(358), 46(361),
>                 78(361), 70(362)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 32.0%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in Secondary Role (Up)
>                 |
>                 | Expected PGs Per OSD: Min: 1132, Max: 1363, Mean:
>                 1248.0, Std Dev: 57.8
>                 |
>                 | Actual PGs Per OSD: Min: 864, Max: 1554, Mean: 1248.0,
>                 Std Dev: 229.9
>                 |
>                 | 5 Most Subscribed OSDs: 182(1554), 142(1552), 4(1548),
>                 123(1544),
>                 100(1540)|
>                 | 5 Least Subscribed OSDs: 16(864), 55(885), 18(885),
>                 42(885), 85(891)
>                 |
>                 | Avg Deviation from Most Subscribed OSD: 19.7%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>                 | OSDs in All Roles (Up)
>                 |
>                 | Expected PGs Per OSD: Min: 1730, Max: 2013, Mean:
>                 1872.0, Std Dev: 70.7
>                 |
>                 | Actual PGs Per OSD: Min: 1252, Max: 2420, Mean:
>                 1872.0, Std Dev: 402.0
>                 |
>                 | 5 Most Subscribed OSDs: 123(2420), 142(2403),
>                 195(2390), 100(2389),
>                 182(2380)|
>                 | 5 Least Subscribed OSDs: 55(1252), 42(1268), 16(1271),
>                 85(1271),
>                 155(1275) |
>                 | Avg Deviation from Most Subscribed OSD: 22.6%
>                 |
>
>                 +-----------------------------__------------------------------__-----------------+
>
>
>
>             --
>             To unsubscribe from this list: send the line "unsubscribe
>             ceph-devel" in
>             the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>             <mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>             More majordomo info at
>             http://vger.kernel.org/__majordomo-info.html
>             <http://vger.kernel.org/majordomo-info.html>
>
>
>
>
>
>     _______________________________________________
>     ceph-users mailing list
>     ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
>
>
> --
> David Burley
> NOC Manager, Sr. Systems Programmer/Analyst
> Slashdot Media
>
> e: david-kIZutuWb7l0/lw2aP8KBIQC/G2K4zDHf@public.gmane.org <mailto:david-kIZutuWb7l0/lw2aP8KBIQC/G2K4zDHf@public.gmane.org>
