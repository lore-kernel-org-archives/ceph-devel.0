From: Loic Dachary <loic@dachary.org>
Subject: Re: crush multipick anomaly
Date: Mon, 13 Feb 2017 19:50:46 +0100
Message-ID: <3486c5b8-1d50-5762-c84a-8d1fcecaa775@dachary.org>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal>
 <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org>
 <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------243EC6F4C775170B80FFD460"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43356 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbdBMSuw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 13:50:52 -0500
In-Reply-To: <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------243EC6F4C775170B80FFD460
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Hi Sage,

I wrote a little program to show where objects are moving when a new disk is added (disk 10 below) and it looks like this:

        00     01     02     03     04     05     06     07     08     09     10 
00:      0     14     17     14     19     23     13     22     21     20   1800 
01:     12      0     11     13     19     19     15     10     16     17   1841 
02:     17     27      0     17     15     15     13     19     18     11   1813 
03:     14     17     15      0     23     11     20     15     23     17   1792 
04:     14     18     16     25      0     27     13      8     15     16   1771 
05:     19     16     22     25     13      0      9     19     21     21   1813 
06:     18     15     21     17     10     18      0     10     18     11   1873 
07:     13     17     22     13     16     17     14      0     25     12   1719 
08:     23     20     16     17     19     18     11     12      0     18   1830 
09:     14     20     15     17     12     16     17     11     13      0   1828 
10:      0      0      0      0      0      0      0      0      0      0      0 

before:  20164  19990  19863  19959  19977  20004  19926  20133  20041  19943      0 
after:   18345  18181  18053  18170  18200  18190  18040  18391  18227  18123  18080 


Each line shows how many objects moved from a given disk to the others after disk 10 was added. Most objects go to the new disk and around 1% go to each other disks. The before and after lines show how many objects are mapped to each disk. They all have the same weight and it's using replica 2 and straw2. Does that look right ?

Cheers

On 02/13/2017 03:21 PM, Sage Weil wrote:
> On Mon, 13 Feb 2017, Loic Dachary wrote:
>> Hi,
>>
>> Dan van der Ster reached out to colleagues and friends and Pedro 
>> López-Adeva Fernández-Layos came up with a well written analysis of the 
>> problem and a tentative solution which he described at : 
>> https://github.com/plafl/notebooks/blob/master/replication.ipynb
>>
>> Unless I'm reading the document incorrectly (very possible ;) it also 
>> means that the probability of each disk needs to take in account the 
>> weight of all disks. Which means that whenever a disk is added / removed 
>> or its weight is changed, this has an impact on the probability of all 
>> disks in the cluster and objects are likely to move everywhere. Am I 
>> mistaken ?
> 
> Maybe (I haven't looked closely at the above yet).  But for comparison, in 
> the normal straw2 case, adding or removing a disk also changes the 
> probabilities for everything else (e.g., removing one out of 10 identical 
> disks changes the probability from 1/10 to 1/9).  The key property that 
> straw2 *is* able to handle is that as long as the relative probabilities 
> between two unmodified disks does not change, then straw2 will avoid 
> moving any objects between them (i.e., all data movement is to or from 
> the disk that is reweighted).
> 
> sage
> 
> 
>>
>> Cheers
>>
>> On 01/26/2017 04:05 AM, Sage Weil wrote:
>>> This is a longstanding bug,
>>>
>>> 	http://tracker.ceph.com/issues/15653
>>>
>>> that causes low-weighted devices to get more data than they should. Loic's 
>>> recent activity resurrected discussion on the original PR
>>>
>>> 	https://github.com/ceph/ceph/pull/10218
>>>
>>> but since it's closed and almost nobody will see it I'm moving the 
>>> discussion here.
>>>
>>> The main news is that I have a simple adjustment for the weights that 
>>> works (almost perfectly) for the 2nd round of placements.  The solution is 
>>> pretty simple, although as with most probabilities it tends to make my 
>>> brain hurt.
>>>
>>> The idea is that, on the second round, the original weight for the small 
>>> OSD (call it P(pick small)) isn't what we should use.  Instead, we want 
>>> P(pick small | first pick not small).  Since P(a|b) (the probability of a 
>>> given b) is P(a && b) / P(b),
>>>
>>>  P(pick small | first pick not small)
>>>  = P(pick small && first pick not small) / P(first pick not small)
>>>
>>> The last term is easy to calculate,
>>>
>>>  P(first pick not small) = (total_weight - small_weight) / total_weight
>>>
>>> and the && term is the distribution we're trying to produce.  For exmaple, 
>>> if small has 1/10 the weight, then we should see 1/10th of the PGs have 
>>> their second replica be the small OSD.  So
>>>
>>>  P(pick small && first pick not small) = small_weight / total_weight
>>>
>>> Putting those together,
>>>
>>>  P(pick small | first pick not small)
>>>  = P(pick small && first pick not small) / P(first pick not small)
>>>  = (small_weight / total_weight) / ((total_weight - small_weight) / total_weight)
>>>  = small_weight / (total_weight - small_weight)
>>>
>>> This is, on the second round, we should adjust the weights by the above so 
>>> that we get the right distribution of second choices.  It turns out it 
>>> works to adjust *all* weights like this to get hte conditional probability 
>>> that they weren't already chosen.
>>>
>>> I have a branch that hacks this into straw2 and it appears to work 
>>> properly for num_rep = 2.  With a test bucket of [99 99 99 99 4], and the 
>>> current code, you get
>>>
>>> $ bin/crushtool -c cm.txt --test --show-utilization --min-x 0 --max-x 40000000 --num-rep 2
>>> rule 0 (data), x = 0..40000000, numrep = 2..2
>>> rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
>>>   device 0:             19765965        [9899364,9866601]
>>>   device 1:             19768033        [9899444,9868589]
>>>   device 2:             19769938        [9901770,9868168]
>>>   device 3:             19766918        [9898851,9868067]
>>>   device 6:             929148  [400572,528576]
>>>
>>> which is very close for the first replica (primary), but way off for the 
>>> second.  With my hacky change,
>>>
>>> rule 0 (data), x = 0..40000000, numrep = 2..2
>>> rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
>>>   device 0:             19797315        [9899364,9897951]
>>>   device 1:             19799199        [9899444,9899755]
>>>   device 2:             19801016        [9901770,9899246]
>>>   device 3:             19797906        [9898851,9899055]
>>>   device 6:             804566  [400572,403994]
>>>
>>> which is quite close, but still skewing slightly high (by a big less than 
>>> 1%).
>>>
>>> Next steps:
>>>
>>> 1- generalize this for >2 replicas
>>> 2- figure out why it skews high
>>> 3- make this work for multi-level hierarchical descent
>>>
>>> sage
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> -- 
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

-- 
Loïc Dachary, Artisan Logiciel Libre

--------------243EC6F4C775170B80FFD460
Content-Type: text/x-csrc;
 name="compare.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="compare.c"

#include "mapper.h"
#include "builder.h"
#include "crush.h"
#include "hash.h"
#include "stdio.h"

#define NUMBER_OF_OBJECTS 100000

void map_with_crush(int replication_count, int hosts_count, int object_map[][NUMBER_OF_OBJECTS]) {
  struct crush_map *m = crush_create();
  m->choose_local_tries = 0;
  m->choose_local_fallback_tries = 0;
  m->choose_total_tries = 50;
  m->chooseleaf_descend_once = 1;
  m->chooseleaf_vary_r = 1;
  m->chooseleaf_stable = 1;
  m->allowed_bucket_algs =
    (1 << CRUSH_BUCKET_UNIFORM) |
    (1 << CRUSH_BUCKET_LIST) |
    (1 << CRUSH_BUCKET_STRAW2);
  int root_type = 1;
  int host_type = 2;  
  int bucketno = 0;

  int hosts[hosts_count];
  int weights[hosts_count];
  int disk = 0;
  for(int host = 0; host < hosts_count; host++) {
    struct crush_bucket *b;

    b = crush_make_bucket(m, CRUSH_BUCKET_STRAW2, CRUSH_HASH_DEFAULT, host_type,
                          0, NULL, NULL);
    assert(b != NULL);
    assert(crush_bucket_add_item(m, b, disk, 0x10000) == 0);
    assert(crush_add_bucket(m, 0, b, &bucketno) == 0);
    hosts[host] = bucketno;
    weights[host] = 0x10000;
    disk++;
  }

  struct crush_bucket *root;
  int bucket_root;

  root = crush_make_bucket(m, CRUSH_BUCKET_STRAW2, CRUSH_HASH_DEFAULT, root_type,
                           hosts_count, hosts, weights);
  assert(root != NULL);
  assert(crush_add_bucket(m, 0, root, &bucket_root) == 0);
  assert(crush_reweight_bucket(m, root) == 0);
  
  struct crush_rule *r;
  int minsize = 1;
  int maxsize = 5;
  int number_of_steps = 3;
  r = crush_make_rule(number_of_steps, 0, 0, minsize, maxsize);
  assert(r != NULL);
  crush_rule_set_step(r, 0, CRUSH_RULE_TAKE, bucket_root, 0);
  crush_rule_set_step(r, 1, CRUSH_RULE_CHOOSELEAF_FIRSTN, replication_count, host_type);
  crush_rule_set_step(r, 2, CRUSH_RULE_EMIT, 0, 0);
  int ruleno = crush_add_rule(m, r, -1);
  assert(ruleno >= 0);

  crush_finalize(m);

  {
    int result[replication_count];
    __u32 weights[hosts_count];
    for(int i = 0; i < hosts_count; i++)
      weights[i] = 0x10000;
    int cwin_size = crush_work_size(m, replication_count);
    char cwin[cwin_size];
    crush_init_workspace(m, cwin);
    for(int x = 0; x < NUMBER_OF_OBJECTS; x++) {
      memset(result, '\0', sizeof(int) * replication_count);
      assert(crush_do_rule(m, ruleno, x, result, replication_count, weights, hosts_count, cwin) == 2);
      for(int i = 0; i < replication_count; i++) {
        object_map[i][x] = result[i];
      }
    }
  }
  crush_destroy(m);
}

int same_set(int object, int replication_count, int before[][NUMBER_OF_OBJECTS], int after[][NUMBER_OF_OBJECTS]) {
  for(int r = 0; r < replication_count; r++) {
    int found = 0;
    for(int s = 0; s < replication_count; s++)
      if(before[r][object] == after[s][object]) {
        found = 1;
        break;
      }
    if(!found)
      return 0;
  }
  return 1;
}

void with_crush(int replication_count, int hosts_count) {
  int before[replication_count][NUMBER_OF_OBJECTS];
  map_with_crush(replication_count, hosts_count, &before[0]);
  int after[replication_count][NUMBER_OF_OBJECTS];
  map_with_crush(replication_count, hosts_count+1, &after[0]);
  int movement[hosts_count + 1][hosts_count + 1];
  memset(movement, '\0', sizeof(movement));
  int count_before[hosts_count + 1];
  memset(count_before, '\0', sizeof(count_before));
  int count_after[hosts_count + 1];
  memset(count_after, '\0', sizeof(count_after));
  for(int object = 0; object < NUMBER_OF_OBJECTS; object++) {
    //    if(same_set(object, replication_count, &before[0], &after[0]))
    //      continue;
    for(int replica = 0; replica < replication_count; replica++) {
      count_before[before[replica][object]]++;
      count_after[after[replica][object]]++;
      if (before[replica][object] == after[replica][object])
        continue;
      movement[before[replica][object]][after[replica][object]]++;
    }
  }
  printf("    ");
  for(int host = 0; host < hosts_count + 1; host++)
    printf("    %02d ", host);
  printf("\n");
  for(int from = 0; from < hosts_count + 1; from++) {
    printf("%02d: ", from);
    for(int to = 0; to < hosts_count + 1; to++)
      printf("%6d ", movement[from][to]);
    printf("\n");
  }

  printf("before: ");
  for(int host = 0; host < hosts_count + 1; host++)
    printf("%6d ", count_before[host]);
  printf("\n");  
  printf("after:  ");
  for(int host = 0; host < hosts_count + 1; host++)
    printf("%6d ", count_after[host]);
  printf("\n");
}

int main(int argc, char* argv[]) {
  int replication_count = atoi(argv[1]);
  int hosts_count = atoi(argv[2]);
  with_crush(replication_count, hosts_count);
}

/*
 * Local Variables:
 * compile-command: "gcc -g -o compare compare.c $(pkg-config --cflags --libs libcrush) && ./compare 2 10"
 * End:
 */

--------------243EC6F4C775170B80FFD460--
