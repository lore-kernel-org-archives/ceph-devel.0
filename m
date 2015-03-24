From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Does crushtool --test --simulate do what cluster
	should do?
Date: Tue, 24 Mar 2015 11:48:10 -0600
Message-ID: <CAANLjFpytozjZiYv8AYszRUEn=au62UN7GJf71LAxw5meeRU6w@mail.gmail.com>
References: <CAANLjFosqAv5a24H0mM9V5b_okXbcb7-1aNskNh14Rf6qLAVUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFosqAv5a24H0mM9V5b_okXbcb7-1aNskNh14Rf6qLAVUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I'm not sure why crushtool --test --simulate doesn't match what the
cluster actually does, but the cluster seems to be executing the rules
even though crushtool doesn't. Just kind of stinks that you have to
test the rules on actual data.

Should I create a ticket for this?

On Mon, Mar 23, 2015 at 6:08 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
> I'm trying to create a CRUSH ruleset and I'm using crushtool to test
> the rules, but it doesn't seem to mapping things correctly. I have two
> roots, on for spindles and another for SSD. I have two rules, one for
> each root. The output of crushtool on rule 0 shows objects being
> mapped to SSD OSDs when it should only be choosing spindles.
>
> I'm pretty sure I'm doing something wrong. I've tested the map on .93 and .80.8.
>
> The map is at http://pastebin.com/BjmuASX0
>
> when running
>
> crushtool -i map.crush --test --num-rep 3 --rule 0 --simulate --show-mappings
>
> I'm getting mapping to OSDs > 39 which are SSDs. The same happens when
> I run the SSD rule, I get OSDs from both roots. It is as if crushtool
> is not selecting the correct root. In fact both rules result in the
> same mapping:
>
> RNG rule 0 x 0 [0,38,23]
> RNG rule 0 x 1 [10,25,1]
> RNG rule 0 x 2 [11,40,0]
> RNG rule 0 x 3 [5,30,26]
> RNG rule 0 x 4 [44,30,10]
> RNG rule 0 x 5 [8,26,16]
> RNG rule 0 x 6 [24,5,36]
> RNG rule 0 x 7 [38,10,9]
> RNG rule 0 x 8 [39,9,23]
> RNG rule 0 x 9 [12,3,24]
> RNG rule 0 x 10 [18,6,41]
> ...
>
> RNG rule 1 x 0 [0,38,23]
> RNG rule 1 x 1 [10,25,1]
> RNG rule 1 x 2 [11,40,0]
> RNG rule 1 x 3 [5,30,26]
> RNG rule 1 x 4 [44,30,10]
> RNG rule 1 x 5 [8,26,16]
> RNG rule 1 x 6 [24,5,36]
> RNG rule 1 x 7 [38,10,9]
> RNG rule 1 x 8 [39,9,23]
> RNG rule 1 x 9 [12,3,24]
> RNG rule 1 x 10 [18,6,41]
> ...
>
>
> Thanks,
