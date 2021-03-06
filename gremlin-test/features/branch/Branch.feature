# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

Feature: Step - branch()

  Scenario: g_V_branchXlabel_eq_person__a_bX_optionXa__ageX_optionXb__langX_optionXb__nameX
    Given the modern graph
    And using the parameter l1 defined as "c[it.get().label() == 'person' ? 'a' : 'b']"
    And the traversal of
      """
      g.V().
        branch(l1).
          option("a", __.values("age")).
          option("b", __.values("lang")).
          option("b", __.values("name"))
      """
    When iterated to list
    Then the result should be unordered
      | result |
      | java |
      | java |
      | lop |
      | ripple |
      | d[29].i |
      | d[27].i |
      | d[32].i |
      | d[35].i |

  Scenario: g_V_branchXlabel_isXpersonX_countX_optionX1__ageX_optionX0__langX_optionX0__nameX
    Given the modern graph
    And the traversal of
      """
      g.V().
        branch(__.label().is("person").count()).
          option(1L, __.values("age")).
          option(0L, __.values("lang")).
          option(0L, __.values("name"))
      """
    When iterated to list
    Then the result should be unordered
      | result |
      | java |
      | java |
      | lop |
      | ripple |
      | d[29].i |
      | d[27].i |
      | d[32].i |
      | d[35].i |

  Scenario: g_V_branchXlabel_isXpersonX_countX_optionX1__ageX_optionX0__langX_optionX0__nameX_optionXany__labelX
    Given the modern graph
    And the traversal of
      """
      g.V().
        branch(__.label().is("person").count()).
          option(1L, __.values("age")).
          option(0L, __.values("lang")).
          option(0L, __.values("name")).
          option(Pick.any, __.label())
      """
    When iterated to list
    Then the result should be unordered
      | result |
      | java |
      | java |
      | lop |
      | ripple |
      | d[29].i |
      | d[27].i |
      | d[32].i |
      | d[35].i |
      | person |
      | person |
      | person |
      | person |
      | software |
      | software |