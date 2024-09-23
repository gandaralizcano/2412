view: sql {
    derived_table: {
      sql: SELECT
          orders.id  AS `orders.id`,
          orders.status  AS `orders.status`
      FROM -- if prod -- demo_db.order_items
         demo_db.order_items
         AS order_items
      LEFT JOIN demo_db.orders  AS orders ON order_items.order_id = orders.id
      GROUP BY
          1,
          2
      ORDER BY
          1
      LIMIT 500 ;;
    }

  dimension: concat_tes {
    type: string
    sql: concat(${orders_id}," -- ",${orders_status}) ;;
    drill_fields: [detail*]
  }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: orders_id {
      type: number
      sql: ${TABLE}.`orders.id` ;;
    }

    dimension: orders_status {
      type: string
      sql: ${TABLE}.`orders.status` ;;
    }

    set: detail {
      fields: [concat_tes,
        orders_id,
        orders_status
      ]
    }
  }
